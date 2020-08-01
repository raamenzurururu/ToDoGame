<template>
  <v-card>
    <v-card-title>
      <h2>TODO</h2>
      <v-spacer></v-spacer>
    </v-card-title>
    <v-data-table :headers="headers" :items="todos">
      <template v-slot:item.action="{ item }">
        <v-icon color="yellow" small @click="deleteItem(item)">mdi-crown</v-icon>
      </template>
    </v-data-table>
  </v-card>
</template>

<script>
import axios from "@/plugins/axios";

export default {
  props: ["todos"], 
  data() {
    return {
      singleSelect: true,
      selected: [],
      search: "",
      headers: [
        {
          text: "タイトル",
          align: "left",
          sortable: false,
          value: "title"
        },
        // { text: "ユーザー名", value: "username" },
        { text: "Actions", value: "action", sortable: false }
      ]
    };
  },
  computed: {
    user() {
      return this.$store.state.currentUser;
    }
  },
  methods: {
    async deleteItem(item) {
      const res = confirm("本当に達成しましたか？");
      if (res) {
        await axios.delete(`/v1/todos/${item.id}`);  //この処理のあとに別のページに飛ばしたい
        const todos = this.user.todos.filter(todo => {
          return todo.id !== item.id;
        });
        const newUser = {
          ...this.user,
          todos
        };
        this.$store.commit("setUser", newUser);
      }
    }
  }
};
</script>

<style>
</style>
