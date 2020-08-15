<template>
  <v-container class="user-page" v-if="user">
    <v-row justify="center">
      <v-col class="user-status" cols="12" xs="12" sm="12" md="12" lg="8">
        <v-row>
          <v-col cols="12" xs="5" sm="6" md="5" lg="6">
            <h2>STATUS</h2>
            <p>NAME：{{ user.name }}</p>
            <p>LV：{{ user.level }}</p>
            <p>EXP：{{ user.experience_point }}</p>
            <p>TP：{{ user.point }}</p>
          </v-col>
          <v-col cols="12" xs="5" sm="6" md="5" lg="6">
            <v-hover v-slot:default="{ hover }">
              <router-link to="/reward">
                <v-btn class="user-btn my-10">
                  <v-icon v-text="hover ? 'mdi-star' : ''"> </v-icon>
                  PRIZE
                </v-btn>
              </router-link>
            </v-hover>

            <v-hover v-slot:default="{ hover }">
              <v-btn class="user-btn" @click="logOut">
                <v-icon v-text="hover ? 'mdi-heart' : ''"> </v-icon>
                BYE
              </v-btn>
            </v-hover>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col cols="12" xs="12" sm="12" md="12" lg="8">
        <div>
          <AddTodo @submit="addTodo" />
        </div>
      </v-col>
    </v-row>
    <v-row justify="center">
      <v-col cols="12" xs="12" sm="12" md="12" lg="8">
        <div>
          <TodoList :todos="user.todos" />
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import AddTodo from "@/components/AddTodo";
import TodoList from "@/components/TodoList";
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
      error: ""
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
    AddTodo,
    TodoList
  },
  computed: {
    user() {
      return this.$store.state.currentUser;
    }
  },
  methods: {
    async addReward(reward) {
      try {
        const { data } = await axios.post("/v1/rewards", {
          reward
        });
        this.$store.commit("setUser", {
          ...this.user,
          rewards: [...this.user.rewards, data]
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
    },
  }
};
</script>

<style lang="scss">
$main-color: deeppink;
$sub-color: orange;

.user-page {
  user-status {
    border: 2px white solid;
  }

  .user-btn {
    background-color: black !important;
    border: 2px solid $main-color;
    color: $main-color;
    width: 100%;
    font-weight: bold;
    font-size: 18px;
    &:hover {
      border: 2px solid white;
      color: blue;
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
