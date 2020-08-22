<template>
  <v-container class="user-page" v-if="currentUser">
    <v-row class="user-status">
      <v-col cols="12" xs="5" sm="6" md="5" lg="5">
        <p>名前：{{ currentUser.user.name }}<v-icon
              class="mb-3"
              color="yellow"
              size="30"
              v-if="(currentUser.user.level = 10)"
              >mdi-crown</v-icon>
        <div class="user-point">
          <img class="coin-img" src="../assets/icon021.png" />
          <p class="user-task-point">{{ currentUser.user.point}}</p>
        </div>
      </v-col>

      <v-col cols="12" xs="5" sm="6" md="5" lg="5">
        <p class="user-level">レベル:{{ currentUser.user.level }}</p>
        <p v-if="(currentUser.user.level == 10)">あなたは最大レベルになりました</p>
      </v-col>
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
$main-color: #03a9f5 !important;
$sub-color: rgb(11, 214, 236) !important;

.user-status {
  border: 2px white solid;
  margin: 0 auto;
  width: 66%;
  background-color: $main-color;
}

h2 {
  text-align: center;
  color: $sub-color;
}
</style>
