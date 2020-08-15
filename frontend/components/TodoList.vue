<template>
  <div>
    <v-card class="pb-5">
      <v-card-title>
        <h2 class="list-title">TODOS</h2>
        <v-spacer></v-spacer>
      </v-card-title>
      <draggable
        class="pl-0"
        v-model="todos"
        :options="{ animation: 200, delay: 50 }"
        @end="atEnd"
        element="ul"
      >
        <li class="todo-list" v-for="todo in todos" :key="todo.sort">
          <span class="todo-point">{{ todo.point }}</span>
          <v-icon size="30px">mdi-numeric-{{ todo.point }}-box-outline</v-icon>
          <v-hover v-slot:default="{ hover }">
            <v-icon @click="completeItem(todo)" size="25px" color="yellow" v-text="hover ? 'mdi-crown' : 'mdi-crown-outline'">
            </v-icon>
          </v-hover>
          <span class="todo-title">{{ todo.title }}</span>
          <div class="todo-list-icon">
            <v-icon @click="editItem(todo)" color=black big>mdi-pencil</v-icon>
            <v-icon small @click="deleteItem(todo)" color=black>delete</v-icon>
          </div>
        </li>
      </draggable>
    </v-card>

    <v-dialog class="edit-dialog" v-model="dialog">
      <v-card>
        <v-card-title>
          <h2 class="list-title">ToDo編集</h2>
        </v-card-title>
        <p>やること</p>
        <v-text-field class="dialog-title" v-model="dialogText.title" filled></v-text-field>
        <p>ポイント</p>
        <v-select class="dialog-point" single-line :items="items" v-model="dialogText.point" :value="dialogText.point" filled></v-select>
        <v-btn class="update-btn" @click="updateItem(dialogText.id, dialogText.title, dialogText.point)">保存</v-btn>
      </v-card>
    </v-dialog>
    <v-snackbar v-model="snack" :timeout="3000" :color="snackColor">
      {{ snackText }}
      <v-btn text @click="snack = false">閉じる</v-btn>
    </v-snackbar>
  </div>
</template>

<script>
const maxNumber = 11;
const numberRange = [...Array(maxNumber).keys()];

import axios from "@/plugins/axios";

export default {
  props: ["todos"],
  data() {
    return {
      singleSelect: true,
      selected: [],
      items: numberRange,
      editOn: true,
      snack: false,
      snackColor: "",
      snackText: "",
      dialogText: "",
      dialog: false,
    };
  },
  computed: {
    user() {
      return this.$store.state.currentUser;
    }
  },
  methods: {
    async completeItem(item) {
      const res = confirm("本当に達成しましたか？");
      if (res) {
        const getUser = await axios.get(`/v1/todos/${item.id}`, {
          params: {
            point: item.point
          }
        });
        const todos = this.user.todos.filter(todo => {
          return todo.id !== item.id;
        });
        const updateUser = {
          // ...this.user,
          // user: getUser.data.user,
          todos,
          untilPercentage: getUser.data.untilPercentage,
          untilLevel: getUser.data.untilLevel,
        };
        this.$store.commit("setUser", updateUser);
        this.snack = true;
        this.snackColor = "success";
        this.snackText = item.point + "タスクポイントと経験値を獲得した!"
      }
    },
    async deleteItem(item) {
      const res = confirm("本当に削除しますか？");
      if (res) {
        await axios.delete(`/v1/todos/${item.id}`); //.then(() => {
        //this.$router.push("/login");
        //}); //これで飛ばせる
        const todos = this.user.todos.filter(todo => {
          return todo.id !== item.id;
        });
        const updateUser = {
          ...this.user,
          todos
        };
        this.$store.commit("setUser", updateUser);
        this.snack = true;
        this.snackColor = "warning";
        this.snackText = "Data deleted";
      }
    },
    async editItem(todo) {
      this.dialog = true;
      this.dialogText = todo;
    },
    async updateItem(id, title, point) {
      await axios.patch(`/v1/todos/${id}`, {
        todo: {
          title: title,
          point: point
        }
      });
      this.dialog = false
    },
    async atEnd() {
      let result = await axios.patch(`v1/todos`, {
        todo: this.todos
      });
      const updateUser = {
        ...this.user,
        todos: this.todos
      };
      this.$store.commit("setUser", updateUser);
    }
  }
};
</script>

<style lang="scss">
$main-color: yellow !important;
$sub-color: #dd8b10;
$accent-color: red;

@mixin btn {
  background-color: rgb(29, 29, 29) !important;
  border: 2px solid $main-color;
  color: $main-color !important;
  display: inline-block;
  margin: 0px 5% 15px;
  width: 70%;
  font-weight: bold;
}
.v-icon {
  display: flex;
  justify-content: center;
}

.todo-list {
  display: flex;
  list-style: none;
  border-left: solid 8px $sub-color !important;
  border-bottom: solid 2px gray !important;
  color: black;
  margin: 10px;
  padding: 10px;
  border: 1px solid #7f7f7f;
  border-radius: 5px;
  background-color: white;
  cursor: grab;
  .todo-list-icon {
    margin-left: auto;
  }
  .todo-list-btn {
    background-color: white !important;
  }
  .todo-title {
    padding-top: 2px;
    margin-left: 10px;
  }
  .todo-point {
    color: rgb(236, 11, 97);
    font-weight: bold;
    display: inline-block;
    width: 25px;
    border-radius: center;
    // background-color: pink;
    box-shadow: inset 0 0 4px rgba(0, 0, 0, 0.08);
    border-bottom: solid 2px yellow;
  }
}

.v-dialog {
  width: 70%;
  h2 {
    color: $sub-color;
  }
  p {
    margin-left: 5%;
  }
  .dialog-title {
    width: 90%;
    margin: 0 auto;
  }
  .dialog-point {
    width: 40%;
    margin-left: 5%;
  }
  .update-btn {
    @include btn
  }
}
</style>
