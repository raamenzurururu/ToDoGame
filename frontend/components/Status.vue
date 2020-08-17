<template>
  <v-container class="user-page" v-if="currentUser">
    <v-row class="user-status">
      <v-col cols="12" xs="5" sm="6" md="5" lg="5">
        <p>名前：{{ currentUser.user.name }}</p>
        <div class="user-point">
          <img class="coin-img" src="../assets/coin.gif">
          <p class="user-task-point">{{ currentUser.user.point }}</p>
        </div>
      </v-col>

      <v-col cols="12" xs="5" sm="6" md="5" lg="5">
        <p class="user-level">レベル:{{ currentUser.user.level }}</p>
        <p>次のレベルまであと{{ currentUser.untilLevel ? currentUser.untilLevel : 50 }} EXP</p>
      </v-col>
        <v-progress-linear
          :height="12"
          :rounded="true"
          :value="currentUser.untilPercentage ? currentUser.untilPercentage : 0"
          color="light-blue"
          striped
        >
        </v-progress-linear>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      show1: false,
      show2: false,
      error: "",
      showContent: false
    };
  },
  fetch({ store, redirect }) {
    store.watch(
      state => state.currentUser,
      (newUser, oldUser) => {
        if (!newUser) {
          return redirect("/login");
        }
      }
    );
  },
  computed: {
    currentUser() {
      return this.$store.state.currentUser;
    }
  },
  methods: {}
};
</script>

<style lang="scss">
$main-color: deeppink;
$sub-color: #33dddd;

.user-status {
  border: 2px white solid;
  margin: 0 auto;
  width: 66%;
  background-color: grey;
}

h2 {
  text-align: center;
  color: $sub-color;
}
</style>
