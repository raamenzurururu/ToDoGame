<template>
  <v-container>
    <div class="user-tp v-inline-block">
      <p>お名前：{{ user.name }}</p>
      <p>レベル：{{ user.level }}</p>
      <p>現在の経験値：{{ user.experience_point }}</p>
      <p>タスクポイント：{{ user.point }}</p>
      <router-link to="/reward">報酬ページへ</router-link>
    </div>
    <AddTodo @submit="addTodo" />
    <TodoList :todos="user.todos" />
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
      items: ["画像1", "画像2"],
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
    user() {
      return this.$store.state.currentUser;
    }
  },
  methods: {
    async addTodo(todo) {
      const { data } = await axios.post("/v1/todos", {
        todo
      });
      //追加
      this.$store.commit("setUser", {
        ...this.user,
        todos: [...this.user.todos, data]
      });
    },
    signup() {
      if (this.password !== this.passwordConfirm) {
        this.error = "※パスワードとパスワード確認が一致していません";
      }
      this.$store.commit("setLoading", true);
      firebase
        .auth()
        .createUserWithEmailAndPassword(this.email, this.password)
        .then(res => {
          const user = {
            email: res.user.email,
            name: this.name,
            uid: res.user.uid
          };
          axios
            .post("/v1/users", {
              user
            })
            .then(res => {
              this.$store.commit("setLoading", false);
              this.$store.commit("setUser", res.data);
              this.$router.push("/user");
            });
        })
        .catch(error => {
          this.error = (code => {
            switch (code) {
              case "auth/email-already-in-use":
                return "既にそのメールアドレスは使われています";
              case "auth/wrong-password":
                return "※パスワードが正しくありません";
              case "auth/weak-password":
                return "※パスワードは最低6文字以上にしてください";
              default:
                return "※メールアドレスとパスワードをご確認ください";
            }
          })(error.code);
        });
    },
    login() {
      this.$store.dispatch("login", {
        email: this.email,
        password: this.password
      });
    },
    openModal: function() {
      this.showContent = true;
    },
    closeModal: function() {
      this.showContent = false;
    },
    moveToTop() {
      const duration = 1000;
      const interval = 25;
      const step = -window.scrollY / Math.ceil(duration / interval);
      const timer = setInterval(() => {
        window.scrollBy(0, step);
        if (window.scrollY <= 0) {
          clearInterval(timer);
        }
      }, interval);
    }
  }
};
</script>

<style lang="scss">
#title {
  display: inline-block;
  background-color: #fc7b03;
  text-align: center;
  margin: 0 auto;
}

.introduction {
  margin-top: 50px;
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

.user-tp {
  border: white solid 2px;
}
</style>
