<template>
  <div>
    <v-card class="pb-5">
      <v-card-title>
        <h2 class="list-title">報酬</h2>
        <v-spacer></v-spacer>
      </v-card-title>
      <draggable
        class="pl-0"
        v-model="rewards"
        :options="{ animation: 200, delay: 50 }"
        @end="atEnd"
        element="ul"
      >
        <li class="reward-list" v-for="reward in rewards" :key="reward.sort">
          <v-hover v-slot:default="{ hover }">
            <v-icon
              @click="openCompleteDialog(reward)"
              size="25px"
              color="red"
              v-text="hover ? 'mdi-heart-multiple' : 'mdi-heart-outline'"
            >
            </v-icon>
          </v-hover>

          <v-dialog v-model="completeDialog">
            <v-card>
              <v-card-title
                >『{{ selectedItem.title }}』をコインで購入しますか？</v-card-title
              >
              <v-btn @click="completeItem(selectedItem)">はい</v-btn>
              <v-btn @click="completeDialog = false">いいえ</v-btn>
            </v-card>
          </v-dialog>

          <span class="reward-title">{{ reward.title }}</span>
          <span class="reward-point">{{ reward.point }}コイン</span>
          <v-icon v-if="reward.status" big color="yellow">check</v-icon>
          <v-icon v-else big color="yellow">monetization_on</v-icon>
        </li>
      </draggable>
    </v-card>

    <v-snackbar v-model="snack" :timeout="3000" :color="snackColor">
      {{ snackText }}
      <v-btn text @click="snack = false">閉じる</v-btn>
    </v-snackbar>
  </div>
</template>

<script>
import axios from "@/plugins/axios";
export default {
  data() {
    return {
      snack: false,
      snackColor: "",
      snackText: "",
      completeDialog: false,
      selectedItem: "",
      rewards: [
        { title: "コーヒーを飲む", point: 1 },
        { title: "歌を聞く", point: 2 },
        { title: "お菓子を食べる", point: 3 },
        { title: "15分寝る", point: 5 },
        { title: "アニメを見る", point: 10 },
        { title: "遊びに行く", point: 30 },
      ]
    };
  },
  methods: {
    async completeItem(item) {
      const getUser = await axios.get(`/v1/rewards/${item.id}`, {
        params: {
          point: item.point
        }
      });
      const rewards = this.user.rewards.filter(reward => {
        return reward.id !== item.id;
      });
      const updateUser = {
        // ...this.user,
        user: getUser.data.user,
        rewards
      };
      this.$store.commit("setUser", updateUser);
      item.status = true;
      this.snack = true;
      this.snackColor = "black";
      this.snackText = item.point + "コインを使った";
      this.completeDialog = false;
    },
    openCompleteDialog(reward) {
      this.completeDialog = true;
      this.selectedItem = reward;
    }
  }
};
</script>

<style lang="scss">
@font-face {
  font-family: dot;
  src: url("../assets/fonts/k8x12S.ttf") format("truetype");
}

.reward-list {
  display: flex;
  list-style: none;
  border: solid 3px red !important;
  border-left: solid 8px deeppink !important;
  margin: 10px;
  padding: 10px;
  border: 1px solid #7f7f7f;
  border-radius: 5px;
  background-color: rgb(73, 4, 25);
  cursor: grab;
  .reward-list-icon {
    margin-left: auto;
  }
  .reward-title {
    margin-left: 10px;
    max-width: 45%;
    color: white;
    font-family: dot;
    letter-spacing: 8px;
    font-weight: bold;
    font-size: 18px;
  }
  .reward-point {
    padding-top: 3px;
    font-weight: bold;
  }
}

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
