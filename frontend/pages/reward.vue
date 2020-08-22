<template>
  <v-container class="user-page" v-if="currentUser">
    <Status />
    <AddReward class="mb-5" @submit="addReward" :reward="currentUser.reward" />
    <RewardList :rewards="currentUser.rewards" />
  </v-container>
</template>

<script>
import AddReward from "@/components/AddReward";
import RewardList from "@/components/RewardList";
import Status from "@/components/Status";
import axios from "@/plugins/axios";
import firebase from "@/plugins/firebase";
export default {
  data() {
    return {
      email: "",
      name: "",
      level: "",
      point: "",
      experience_point: "",
      password: "",
      passwordConfirm: "",
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
  components: {
    AddReward,
    RewardList,
    Status
  },
  computed: {
    currentUser() {
      return this.$store.state.currentUser;
    }
  },
  methods: {
    async addReward(reward) {
      try {
        const { data } = await axios.post("/v1/rewards", {
          reward
        });
        const userReward = this.currentUser.reward
          ? this.currentUser.rewards
          : [];
        this.$store.commit("setUser", {
          ...this.currentUser,
          rewards: [...userReward, data]
        });
        this.$store.commit("clearErrors");
      } catch (error) {
        const { data } = error.response;
        this.$store.commit("setError", data.error_msg);
      }
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
    }
  }
};
</script>

<style lang="scss">
$main-color: white;
$sub-color: orange;

.user-page {
  user-status {
    border: 2px white solid;
    margin: 0 auto;
    width: 66%;
    background-color: grey;

    .coin-img {
      width: 20%;
      display: inline-block;
    }

    .user-point {
      display: flex;
      .user-task-point {
        font-size: x-large;
        color: rgb(238, 238, 37);
        padding-left: 2%;
        padding-top: 8px;
        margin-bottom: 0px;
      }
    }
  }

  .user-btn {
    background-color: black !important;
    border: 2px solid $main-color;
    color: $main-color;
    width: 100%;
    font-weight: bold;
    font-size: 18px;
    &:hover {
      border: 2px solid yellow;
      color: yellow;
    }
  }
  h2,
  h1 {
    text-align: center;
    color: $sub-color;
  }
  a {
    text-decoration: none;
  }
  p {
    font-size: 20px;
    font-weight: bold;
  }
}

.introduction h3 {
  text-align: center;
  margin: 0 auto;
  color: aqua !important;
}

.v-img {
  text-align: center;
}

.v-window__container {
  border: solid 5px white;
}

#overlay {
  z-index: 1;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 30, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
