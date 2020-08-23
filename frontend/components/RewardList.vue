<template>
  <v-card max-width="730" class="mx-auto">
    <v-toolbar color="blue" dark>
      <v-toolbar-title>報酬</v-toolbar-title>
      <v-spacer></v-spacer>
    </v-toolbar>

    <v-list>
      <v-list-group
        v-for="item in items"
        :key="item.title"
        v-model="item.active"
        :prepend-icon="item.action"
        active-class="blue--text"
      >
        <template v-slot:activator>
          <v-list-item-content>
            <v-list-item-title v-text="item.title"></v-list-item-title>
          </v-list-item-content>
        </template>

        <v-list-item
          v-for="subItem in item.items"
          :key="subItem.title"
        >
          <v-list-item-content>
            <v-list-item-title v-text="subItem.title"></v-list-item-title>
            <v-hover v-slot:default="{ hover }">
            <v-icon
              @click="completeDialog = true"
              size="25px"
              color="red"
              v-text="hover ? 'mdi-heart-multiple' : 'mdi-heart-outline'"
            >
            </v-icon>
          </v-hover>
          </v-list-item-content>

          <v-dialog v-model="completeDialog">
            <v-card>
              <v-card-title
                >『{{ subItem.title }}』を{{ subItem.point }}コインで購入しますか？</v-card-title
              >
              <v-btn @click="completeItem(subItem)">はい</v-btn>
              <v-btn @click="completeDialog = false">いいえ</v-btn>
            </v-card>
          </v-dialog>

          <v-list-item-action>
            <v-list-item-action-text v-text="subItem.point + 'コイン'"></v-list-item-action-text>
            <v-icon v-if="!completeDialog" color="grey lighten-1">
              mdi-currency-usd-circle-outline
            </v-icon>
            <v-icon v-else color="yellow">
              mdi-currency-usd-circle
            </v-icon>
          </v-list-item-action>
        </v-list-item>
      </v-list-group>
    </v-list>
  </v-card>
</template>

<script>
import axios from "@/plugins/axios";
export default {
  data() {
    return {
      completeDialog: false,
      items: [
        {
          action: "restaurant",
          title: "食事",
          active: true,
          items: [
            { title: "コーヒーを飲む", point: 1 },
            { title: "お菓子を食べる", point: 2 },
            { title: "寿司を食べる", point: 10 },
          ]
        },
        {
          action: "local_activity",
          title: "Attractions",
          items: [{ title: "List Item" }]
        },
        {
          action: "mdi-hot-tub",
          title: "休憩",
          items: [{ title: "１５分寝る" }, { title: "お風呂に入る" }]
        },
        {
          action: "directions_run",
          title: "Family",
          items: [{ title: "List Item" }]
        },
        {
          action: "healing",
          title: "Health",
          items: [{ title: "List Item" }]
        },
        {
          action: "mdi-emoticon-kiss-outline",
          title: "むふふ",
          items: [{ title: "恋人に会う" }]
        },
        {
          action: "local_offer",
          title: "Promotions",
          items: [{ title: "List Item" }]
        }
      ]
    };
  },
  methods: {
    async completeItem(item) {
      const getUser = await axios.get(`/v1/rewards/${item.id}`, {
        params: {
          point: this.subItem.point
        }
      });
      const rewards = this.user.todos.filter(todo => {
        return todo.id !== item.id;
      });
      const updateUser = {
        // ...this.user,
        user: getUser.data.user,
        todos
      };
      this.$store.commit("setUser", updateUser);
      this.snack = true;
      this.snackColor = "black";
      this.snackText = item.point + "コインを手に入れた";
      this.completeDialog = false;
    },
  }
};
</script>

<style lang="scss">
$main-color: #03a9f5 !important;
$sub-color: rgb(11, 214, 236) !important;
$accent-color: red;

.v-dialog {
  width: 70%;
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
}
</style>
