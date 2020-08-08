<template>
  <div v-if="user">
    <p>{{ user.name }}</p>
    <p class="user-tp d-inline-block">タスクポイント:{{ user.point }}</p>
    <AddTodo @submit="addTodo" />
    <router-link to="/reward">報酬</router-link>
    <TodoList :todos="user.todos" />
  </div>
</template>

<script>
import AddTodo from "@/components/AddTodo";
import TodoList from "@/components/TodoList";
import axios from "@/plugins/axios";

export default {
  data() {
    return {
      point: "",
      show1: false
    };
  },
  components: {
    AddTodo,
    TodoList
  },
  computed: {
    user() {
      return this.$store.state.currentUser;
    },
    errors() {
      return this.$store.state.errors;
    }
  },
  fetch({ store, redirect }) {
    store.watch(
      state => state.currentUser,
      (newUser, oldUser) => {
        console.log({ newUser });
        if (!newUser) {
          return redirect("/login");
        }
      }
    );
  },
  methods: {
    async addTodo(todo) {
      const { data } = await axios.post("/v1/todos", { todo });
      this.$store.commit("setUser", {
        ...this.user,
        todos: [...this.user.todos, data]
      });
    }
  }
};
</script>

<style>
.user-tp {
  border: blue solid 2px;
}
</style>
