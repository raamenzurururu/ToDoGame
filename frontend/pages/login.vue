<template>
  <v-row>
    <v-col cols=12 sm=10 md=8 lg=4 xl=3>
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
    <Transitions></Transitions>
    <Progress></Progress>
  </v-row>
</template>

<script>
import firebase from "@/plugins/firebase";
import Transitions from "@/components/Transitions.vue"
import Progress from "@/components/Progress.vue"

export default {
  components: {
    Transitions,
    Progress
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
