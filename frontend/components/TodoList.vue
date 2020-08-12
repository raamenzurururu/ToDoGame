<template>
  <v-card>
    <v-card-title>
      <h2 class="list-title">TODOS</h2>
      <v-spacer></v-spacer>
    </v-card-title>
    <v-data-table :headers="headers" :items="todos">
      <template v-slot:item.point="props">
        <v-edit-dialog :return-value="props.item.point">
          <!-- .syncを消すことでPointをリアルタイムで反映できる -->
          {{ props.item.point }}
          <template v-slot:input>
            <v-select
              @change="updatePoint(props.item.id, props.item.point)"
              v-model="props.item.point"
              :items="items"
              single-line
            ></v-select>
          </template>
        </v-edit-dialog>
      </template>

      <template v-slot:item.title="props">
        <v-edit-dialog :return-value.sync="props.item.title">
          {{ props.item.title }}
          <template v-slot:input>
            <v-text-field
              @change="updateTitle(props.item.id, props.item.title)"
              v-model="props.item.title"
              label="Edit"
              single-line
              counter
            ></v-text-field>
          </template>
        </v-edit-dialog>
      </template>
      <template v-slot:item.complete="{ item }">
        <v-hover v-slot:default="{ hover }">
          <v-icon
            color="yellow"
            @click="completeItem(item)"
            v-text="hover ? 'mdi-crown' : 'mdi-crown-outline'"
          ></v-icon>
        </v-hover>
      </template>
      <template v-slot:item.action="{ item }">
        <v-icon small @click="deleteItem(item)">delete</v-icon>
      </template>
    </v-data-table>
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
      search: "",
      editOn: true,
      items: numberRange,
      headers: [
        {
          text: "ToDo",
          align: "left",
          sortable: false,
          value: "title"
        },
        { text: "Task Point(TP)", value: "point" },
        { text: "Goal", value: "complete" },
        // { text: "Edit", value: "edit", sortable: false },
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
