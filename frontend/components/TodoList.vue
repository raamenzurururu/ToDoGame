<template>
  <v-card>
    <v-card-title>
      <h2 class="list-title">TODOS</h2>
      <v-spacer></v-spacer>
    </v-card-title>
    <ul>
      <draggable v-model="todos" :options="{ animation: 200, delay: 50 }" @end="atEnd">
        <li class="todo-list" v-for="todo in todos" :key="todo.point">
          <v-hover v-slot:default="{ hover }">
            <v-icon color="blue" v-text="hover ? 'mdi-crown' : 'mdi-crown-outline'">
            </v-icon>
          </v-hover>
          <v-hover v-slot:default="{ hover }">
            <v-icon @click="completeItem(todo)" color="blue" v-text="hover ? 'mdi-star-half' : 'mdi-star-outline'">
            </v-icon>
          </v-hover>
          <span class="todo-point">{{ todo.point }}</span>
          {{ todo.title }}
        </li>
      </draggable>
    </ul>
  </v-card>
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
          todos
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
    async editItem(item) {
      this.editOn = !this.editOn;
    },
    async updateTitle(id, value) {
      await axios.patch(`/v1/todos/${id}`, {
        todo: {
          title: value
        }
      });
    },
    async updatePoint(id, value) {
      let result =
        await axios.patch(`/v1/todos/${id}`, {
          todo: {
            point: value
          }
        });
    },
    async atEnd() {
      let result =
        await axios.patch(`v1/todos`, {
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
.v-icon {
  display: flex;
  justify-content: center;
}

.todo-list {
  list-style: none;
  color: black;
  margin: 10px;
  padding: 10px;
  border: 1px solid #7f7f7f;
  border-radius: 10px;
  background-color: white;
  .todo-list-btn {
    background-color: white !important;
  }
  .todo-point {
    color: pink;
    font-weight: bold;
  }
}
</style>
