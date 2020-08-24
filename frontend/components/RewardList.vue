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
          <v-icon size="30px" color="red"
            >mdi-numeric-{{ reward.point }}-circle-outline</v-icon
          >
          <v-hover v-slot:default="{ hover }">
            <v-icon
              @click="completeDialog = true"
              size="25px"
              color="red"
              v-text="hover ? 'mdi-heart-multiple' : 'mdi-heart-outline'"
            >
            </v-icon>
          </v-hover>

          <v-dialog v-model="completeDialog">
            <v-card>
              <v-card-title
                >『{{ reward.title }}』を{{
                  reward.point
                }}コインで購入しますか？</v-card-title
              >
              <v-btn @click="completeItem(reward)">はい</v-btn>
              <v-btn @click="completeDialog = false">いいえ</v-btn>
            </v-card>
          </v-dialog>

          <span class="reward-title">{{ reward.title }}</span>
        </li>
      </draggable>
    </v-card>
  </div>
</template>

<script>
import axios from "@/plugins/axios";
export default {
  data() {
    return {
      completeDialog: false,
      rewards: [
        { title: "りんご", point: 1 },
        { title: "コーヒーを飲む", point: 2 }
      ]
    };
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
