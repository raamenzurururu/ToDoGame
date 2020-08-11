<template>
  <div>
    <v-card>
      <!-- Edit -->
      <v-card-title>
        <h2>報酬</h2>
        <v-spacer></v-spacer>
      </v-card-title>
      <v-data-table :headers="headers" :items="rewards">
        <!-- ここにアイテムの名前が表示される/itemsをitemに入れるのがv-data-tableの機能-->
        <template v-slot:item.point="props">
          <v-edit-dialog
            :return-value="props.item.point"
            @save="save"
            @cancel="cancel"
            @open="open"
            @close="close"
          >
            {{ props.item.point }}
            <template v-slot:input>
              <v-select
                @change="updatePoint(props.item.id, props.item.point)"
                @save="save"
                @cancel="cancel"
                @open="open"
                @close="close"
                v-model="props.item.point"
                :items="items"
                single-line
              ></v-select>
              <!-- itemsは元々v-selectに存在している -->
            </template>
          </v-edit-dialog>
        </template>

        <template v-slot:item.title="props">
          <v-edit-dialog
            @save="save"
            @cancel="cancel"
            @open="open"
            @close="close"
            :return-value.sync="props.item.title"
          >
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

        <template v-slot:item.action="{ item }">
          <v-icon midium @click="deleteItem(item)">delete</v-icon>
        </template>

        <template v-slot:item.complete="{ item }">
          <v-icon v-if="item.status" color="yellow" @click="completeItem(item)"
            >lock_open</v-icon
          >
          <v-icon v-else color="yellow" @click="completeItem(item)"
            >lock</v-icon
          >
        </template>
        <!-- 編集ボタン -->
        <!-- <div v-if="editOn"></div>
        <div v-else class="edit-window">
          <p>編集画面</p>
          <v-text-field label="Edit" counter></v-text-field>
          <v-icon smaill @click="changeItem">update</v-icon>
        </div>-->
      </v-data-table>
    </v-card>
    <v-snackbar v-model="snack" :timeout="3000" :color="snackColor">
      {{ snackText }}
      <v-btn text @click="snack = false">Close</v-btn>
    </v-snackbar>
  </div>
</template>

<script>
const maxNumber = 11;
const numberRange = [...Array(maxNumber).keys()];

import axios from "@/plugins/axios";
export default {
  props: ["rewards"],
  data() {
    return {
      singleSelect: true,
      selected: [],
      editOn: true,
      items: numberRange,
      snack: false,
      snackColor: "",
      snackText: "",

      headers: [
        {
          text: "ゲット",
          width: "170",
          value: "complete"
        },
        {
          text: "TaskPoint(TP)",
          value: "point",
          width: "170"
        },
        {
          text: "報酬",
          align: "left",
          sortable: false,
          value: "title"
        },
        {
          text: "削除",
          value: "action",
          sortable: false
        }
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
        await axios.delete(`/v1/rewards/${item.id}`);
        const rewards = this.user.rewards.filter(reward => {
          return reward.id !== item.id;
        });
        const updateUser = {
          ...this.user,
          rewards
        };
        this.$store.commit("setUser", updateUser);
        this.snack = true;
        this.snackColor = "warning";
        this.snackText = "Data deleted";
      }
    },
    async completeItem(item) {
      const res = confirm("本当に達成しますか？");
      if (res) {
        const getUser = await axios.get(`/v1/rewards/${item.id}`, {
          params: {
            point: item.point
          }
        });
        item.status = true;
        const rewards = this.rewards;
        this.user.level = getUser.data.user.level;
        this.user.point = getUser.data.user.point;
        this.user.experience_point = getUser.data.user.experience_point;
        const updateUser = {
          ...this.user,
          rewards
        };
        this.$store.commit("setUser", updateUser);
        this.snack = true;
        this.snackColor = "success";
        this.snackText = "Data saved";
      }
    },
    async editItem(item) {
      this.editOn = !this.editOn;
    },
    async updateTitle(id, value) {
      await axios.patch(`/v1/rewards/${id}`, {
        reward: {
          title: value
        }
      });
    },
    async updatePoint(id, value) {
      await axios.patch(`/v1/rewards/${id}`, {
        reward: {
          point: value
        }
      });
    },
    logOut() {
      firebase
        .auth()
        .signOut()
        .then(() => {
          this.$store.commit("setUser", null);
          this.$router.push("/");
        })
        .catch(error => {
          console.log(error);
        });
    },
    save() {
      this.snack = true;
      this.snackColor = "success";
      this.snackText = "Data saved";
    },
    cancel() {
      this.snack = true;
      this.snackColor = "error";
      this.snackText = "Canceled";
    },
    open() {
      this.snack = true;
      this.snackColor = "info";
      this.snackText = "Dialog opened";
    },
    close() {
      console.log("Dialog closed");
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
