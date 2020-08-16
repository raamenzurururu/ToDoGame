<template>
  <v-row class="user-status" id="v-step-2">
    <v-col cols="12" xs="5" sm="6" md="6" lg="6">
      <p>
        名前：{{ currentUser.user.name}}
        <v-icon class="mb-2" color="yellow" size="30" v-if="currentUser.user.level == 10">mdi-crown</v-icon>
      </p>
      <div class="user-point">
        <p class="user-task-point">
          <v-icon class="mb-1" size="30" color="yellow">mdi-alpha-p-circle</v-icon>
          {{ currentUser.user.point }}
        </p>
      </div>
    </v-col>
    <v-col cols="12" xs="5" sm="6" md="6" lg="6">
      <p class="user-level">レベル：{{ currentUser.user.level }}</p>
      <p v-if="currentUser.user.level !== 10">
        次のレベルまであと
        {{ currentUser.untilLevel ? currentUser.untilLevel : 50 }} EXP
      </p>
      <p v-else>最大レベルです！</p>
      <v-progress-linear :height="12" :rounded="true" straped
        :value="currentUser.untilPercentage ? currentUser.untilPercentage : 0" color="light-blue"></v-progress-linear>
    </v-col>
  </v-row>
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
  methods: {
  }
};
</script>

<style lang="scss">
$main-color: deeppink;
$sub-color: #33dddd;

.user-page {
  user-status {
    border: 2px white solid;
  }
}
h2 {
  text-align: center;
  color: $sub-color;
}
