<template>
  <v-card>
    <v-card-title>
      <h2>TODO</h2>
      <v-spacer></v-spacer>
    </v-card-title>
    <v-data-table :headers="headers" :items="todos">
      <template v-slot:item.complete="{ item }">
        <v-icon big color="yellow" @click="completeItem(item)">mdi-crown-outline</v-icon>
      </template>
      <template v-slot:item.action="{ item }">
        <v-icon small @click="deleteItem(item)">delete</v-icon>
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
          text: "ToDo",
          align: "left",
          sortable: false,
          value: "title"
        },
        { text: "Task Point(TP)" , value: "point" },
        { text: "goal", value: "complete"},
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
      const res = confirm("本当に削除しますか？");
      if (res) {
        await axios.delete(`/v1/todos/${item.id}`)//.then(() => {
          //this.$router.push("/login");
        //}); //これで飛ばせる
        const todos = this.user.todos.filter(todo => {
          return todo.id !== item.id;
        });
        const newUser = {
          ...this.user,
          todos
        };
        this.$store.commit("setUser", newUser);
      }
    },
    async completeItem(item) {
      const res = confirm("本当に達成しましたか？");
      if (res) {
        await axios.get(`/v1/todos/${item.id}`,
          {
            params: {
              point: this.todos.point
            }});
        const todos = this.user.todos.filter(todo => {
          return todo.id !== item.id;
        });
        const points = this.user.point
        const newUser = {
          ...this.user,
          todos,
          points
        };
        this.$store.commit("setUser", newUser);
      }
    }
  }
};
</script>

<style>
</style>

