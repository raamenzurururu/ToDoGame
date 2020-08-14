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
        <li class="todo-list" v-for="todo in todos" :key="todo.point">
          <v-hover v-slot:default="{ hover }">
            <v-icon
              color="blue"
              v-text="hover ? 'mdi-crown' : 'mdi-crown-outline'"
            >
            </v-icon>
          </v-hover>
          <v-hover v-slot:default="{ hover }">
            <v-icon
              @click="completeItem(todo)"
              color="blue"
              v-text="hover ? 'mdi-star' : 'mdi-star-outline'"
            >
            </v-icon>
          </v-hover>
          <v-icon @click="editItem(todo)">mdi-pencil</v-icon>
          <v-icon small @click="deleteItem(todo)">delete</v-icon>
          <span class="todo-point">{{ todo.point }}</span>
          {{ todo.title }}
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
      dialogText: "",
      dialog: false
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
        this.user.level += getUser.data.user.level;
        this.user.point = getUser.data.user.point;
        this.user.experience_point += getUser.data.user.experience_point;
        const updateUser = {
          ...this.user,
          todos: this.todos
        };
        this.$store.commit("setUser", updateUser);
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
  // list-style: none;
  color: white;
  margin: 10px;
  padding: 10px;
  border: 1px solid #7f7f7f;
  border-radius: 5px;
  background-color: rgb(10, 9, 9);
  .todo-list-btn {
    background-color: white !important;
  }
  .todo-point {
    color: rgb(236, 11, 97);
    font-weight: bold;
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
