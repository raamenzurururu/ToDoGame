<template>
  <v-row>
    <v-col cols=12 sm=12 md=6 lg=6>
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
    <v-col cols=12 sm=12 md=6 lg=6>
    <Transitions></Transitions>
    </v-col>
    <v-col>
    <Progress></Progress>
    </v-col>
    <v-col>
    <Timeline></Timeline>
    </v-col>
  </v-row>
</template>

<script>
import firebase from "@/plugins/firebase";
import Transitions from "@/components/Transitions.vue"
import Progress from "@/components/Progress.vue"
import Timeline from "@/components/Timeline.vue"


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
    }
  }
};
</script>
<style scoped>
.errors {
  color: red;
  margin-top: 20px;
}
</style>
