<template>
  <v-row>
    <v-col cols="12" sm="12" md="12" lg="12">
      <Transitions></Transitions>
    </v-col>
    <v-col cols="12" sm="12" md="6" lg="6">
      <h2>ログイン</h2>
      <form>
        <v-text-field
          v-model="email"
          :counter="20"
          label="email"
          data-vv-name="email"
          required
        ></v-text-field>
        <v-text-field
          v-model="password"
          label="password"
          data-vv-name="password"
          required
          :type="show1 ? 'text' : 'password'"
          :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="show1 = !show1"
        ></v-text-field>
        <v-btn class="mr-4" @click="login">submit</v-btn>
        <p v-if="error" class="errors">{{ error }}</p>
      </form>
    </v-col>
    <v-col>
      <Progress></Progress>
    </v-col>
    <v-col>
      <Timeline></Timeline>
    </v-col>
    <v-btn v-on:click="moveToTop" class="topbt">新規登録する？</v-btn>
  </v-row>
</template>

<script>
import firebase from "@/plugins/firebase";
import Transitions from "@/components/Vuetify/Transitions.vue";
import Progress from "@/components/Vuetify/Progress.vue";
import Timeline from "@/components/Vuetify/Timeline.vue";

export default {
  components: {
    Transitions,
    Progress,
    Timeline
  },
  data() {
    return {
      email: "",
      password: "",
      show1: false,
      error: ""
    };
  },
  methods: {
    login() {
      this.$store.dispatch("login", {
        email: this.email,
        password: this.password
      });
    },
    moveToTop() {
      const duration = 1000; // 移動速度（1秒で終了）
      const interval = 25; // 0.025秒ごとに移動
      const step = -window.scrollY / Math.ceil(duration / interval); // 1回に移動する距離
      const timer = setInterval(() => {
        window.scrollBy(0, step); // スクロール位置を移動

        if (window.scrollY <= 0) {
          clearInterval(timer);
        }
      }, interval);
    }
  }
};
</script>
<style scoped>
.errors {
  color: red;
  margin-top: 20px;
}

.topbt:hover {
  color: yellow;
  border: 2px solid yellow;
}
</style>
