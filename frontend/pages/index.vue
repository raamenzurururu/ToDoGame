<template>
  <div v-if="currentUser">
    <div class="user-tp v-inline-block">
      <p>名前 :{{ currentUser.user.name }}</p>
      <p>レベル :{{ currentUser.user.level }}</p>
      <p>現在の経験値 :{{ currentUser.user.experience_point }}</p>
      <p class="user-tp d-inline-block">タスクポイント:{{ currentUser.user.point }}</p>
      <router-link to="/reward">報酬</router-link>
    </div>
      <AddTodo @submit="addTodo" />
    <TodoList :todos="currentUser.todos" />
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
      show1: false,
      level: "",
      experience_point: ""
    };
  },
  components: {
    AddTodo,
    TodoList
  },
  computed: {
    currentUser() {
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
        ...this.currentUser,
        todos: [...this.user.todos, data]
      });
    }
  }
};
</script>

<style>
.user-tp {
  border: black solid 2px;
}
</style>
