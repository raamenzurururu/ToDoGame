<template>
  <v-container class="user-page" v-if="user">
    <v-row justify="center">
      <v-col class="user-status" cols="12" xs="6" sm="8" md="10" lg="7">
        <v-row>
          <v-col cols="12" xs="6" sm="8" md="10" lg="6">
            <h2>STATUS</h2>
            <p>NAME：{{ user.name }}</p>
            <p>LV：{{ user.level }}</p>
            <p>EXP：{{ user.experience_point }}</p>
            <p>TP：{{ user.point }}</p>
          </v-col>
          <v-col cols="12" xs="6" sm="8" md="5" lg="6">
            <p>右</p>
            <router-link to="/reward">報酬ページへ</router-link>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col cols="12" xs="6" sm="12" md="12" lg="8">
        <div>
          <AddTodo @submit="addTodo" />
        </div>
      </v-col>
    </v-row>
    <TodoList :todos="user.todos" />
  </v-container>
</template>

<script>
import AddTodo from "@/components/AddTodo";
import TodoList from "@/components/TodoList";
import axios from "@/plugins/axios";
import firebase from "@/plugins/firebase";
export default {
  data() {
    return {
      email: "",
      name: "",
      level: "",
      point: "",
      experience_point: "",
      password: "",
      passwordConfirm: "",
      show1: false,
      show2: false,
      error: "",
    };
  },
  fetch({ store, redirect }) {
    store.watch(
      state => state.currentUser,
      (newUser, oldUser) => {
        if (!newUser) {
          return redirect("/login");
        }
      }
    );
  },
  computed: {
    user() {
      return this.$store.state.currentUser;
    }
  },
  methods: {
  }
};
</script>

<style lang="scss">
$main-color: deeppink;
$sub-color: #33dddd;

.user-page {
  user-status {
    border: 2px white solid;
  }
}
h2 {
  text-align: center;
  color: $sub-color;
}
