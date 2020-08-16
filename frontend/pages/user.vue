<template>
  <v-container class="user-page" v-if="currentUser">
    <v-row class="user-status" justify="center">
      <v-col cols="12" xs="5" sm="6" md="5" lg="4">
        <h2>{{ currentUser.user.name }}のステータス</h2>
        <p>名前：{{ currentUser.user.name }}</p>
        <p>レベル：{{ currentUser.user.level }}</p>
        <p>
          次のレベルまであと{{
            currentUser.untilLevel ? currentUser.untilLevel : 50
          }}
        </p>
        <v-progress-linear
          :height="12"
          :rounded="true"
          :value="currentUser.untilPercentage ? currentUser.untilPercentage : 0"
          color="light-blue"
          striped
        >
        </v-progress-linear>
        <p>経験値：{{ currentUser.user.experience_point }}</p>
        <p>
          タスクポイント：{{
            currentUser.user.point ? currentUser.user.experience_point : 50
          }}
        </p>
      </v-col>
      <v-col cols="12" xs="5" sm="6" md="5" lg="6">
        <v-hover v-slot:default="{ hover }">
          <router-link to="/reward">
            <v-btn class="user-btn my-10">
              <v-icon v-text="hover ? 'mdi-treasure-chest' : ''"> </v-icon>
              REWARD
            </v-btn>
          </router-link>
        </v-hover>

        <v-hover v-slot:default="{ hover }">
          <v-btn class="user-btn" @click="logOut">
            <v-icon v-text="hover ? 'mdi-logout-variant' : ''"> </v-icon>
            BYE
          </v-btn>
        </v-hover>
      </v-col>
    </v-row>

    <v-row justify="center">
      <v-col cols="12" xs="12" sm="12" md="12" lg="8">
        <div>
          <AddTodo @submit="addTodo" />
        </div>
      </v-col>
    </v-row>
    <div class="errors text-center" v-if="$store.state.errors">
      <span v-for="error in $store.state.errors" :key="error">
        <div>{{ error }}</div>
      </span>
    </div>
    <v-row justify="center">
      <v-col cols="12" xs="12" sm="12" md="12" lg="8">
        <div>
          <TodoList :todos="currentUser.todos" />
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
    AddTodo,
    TodoList
  },
  computed: {
    currentUser() {
      return this.$store.state.currentUser;
    }
  },
  methods: {
    async addTodo(todo) {
      try {
        const { data } = await axios.post("/v1/todos", {
          todo
        });
        console.log(data);
        this.$store.commit("setUser", {
          ...this.currentUser,
          todos: [...this.currentUser.todos, data]
        });
        this.$store.commit("clearErrors");
      } catch (error) {
        console.log("UserPage: 112", error);
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

$pc: 1024px;
$tab: 680px;
$sp: 480px;

@mixin pc {
  @media (max-width: ($pc)) {
    @content;
  }
}

@mixin tab {
  @media (max-width: ($tab)) {
    @content;
  }
}
@mixin sp {
  @media (max-width: ($sp)) {
    @content;
  }
}

.user-page {
  .user-status {
    border: 2px white solid;
    margin: 0 auto;
    width: 66%;
  }

  .user-status {
    @include pc {
      width: 100%;
    }
    @include tab {
      width: 100% !important;
    }
    @include sp {
      width: 100% !important;
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
      color: white;
    }
  }
  list-title,
  h2 {
    text-align: center;
    color: $sub-color;
  }
  p {
    font-size: 20px;
    font-weight: bold;
  }
}
</style>
