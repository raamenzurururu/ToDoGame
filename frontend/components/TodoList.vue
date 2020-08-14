<template>
  <v-card>
    <v-card-title>
      <h2 class="list-title">TODOS</h2>
      <v-spacer></v-spacer>
    </v-card-title>
    <ul>
      <li><span>【達成ボタン】</span>【編集ボタン】</li>
      <draggable v-model="todos">
        <li v-for="todo in todos" :key="todo.point">
          Point{{ todo.title }}:{{ todo.title }}
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
    }
  }
};
</script>

<style>
.v-icon {
  display: flex;
  justify-content: center;
}

.edit-window {
  /*　要素を重ねた時の順番　*/
  z-index: 1;

  /*　画面全体を覆う設定　*/
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 30, 0.5);

  /*　画面の中央に要素を表示させる設定　*/
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
