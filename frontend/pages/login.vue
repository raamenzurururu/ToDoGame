<template>
  <v-container class="login-page">
    <h1 class="login-title">ToDo<span class="login-title-first">Game</span></h1>
    <v-row>
      <v-col cols="12" sm="12" md="6" lg="6">
        <h2 class="login-subtitle md-3 text-center">ToDoをゲームに</h2>
        <h3>Kazuki to train on the web!!!!!!!!!!</h3>
      </v-col>
      <v-col v-if="user" cols="12" sm="12" md="6" lg="6">
        <p>ログインしているユーザーには見えない</p>
      </v-col>
      <v-col v-else cols="12" sm="12" md="6" lg="6">
        <form>
          <h2 class="login-form-title text-center">新規登録こちら</h2>
          <v-text-field
            v-model="name"
            :counter="10"
            label="Name"
            data-vv-name="name"
            required
          ></v-text-field>
          <v-text-field
            v-model="email"
            :counter="20"
            label="Email"
            data-vv-name="email"
            required
          ></v-text-field>
          <v-text-field
            v-model="password"
            :counter="20"
            label="password"
            data-vv-name="password"
            required
            :type="show1 ? 'text' : 'password'"
            :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show1 = !show2"
          ></v-text-field>
          <v-text-field
            v-model="passwordConfirm"
            :counter="20"
            label="passwordConfirm"
            data-vv-name="passwordConfirm"
            required
            :type="show1 ? 'text' : 'password'"
            :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show1 = !show2"
          ></v-text-field>
          <v-btn class="mr-4" @click="signup">submit</v-btn>
          <p v-if="error" class="errors">{{ error }}</p>
        </form>
      </v-col>
    </v-row>
    <v-row class="introduction">
      <v-col cols="12" sm="12" md="4" lg="4">
        <v-img
          width="50%"
          height="50%"
          src="https://images.unsplash.com/photo-1519669556878-63bdad8a1a49?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1651&q=80"
        >
        </v-img>
        <h3>Shine like a diamond</h3>
        <p>I see you shining</p>
      </v-col>
      <v-col cols="12" sm="12" md="4" lg="4">
        <v-img
          width="50%"
          height="50%"
          src="https://images.unsplash.com/photo-1519669556878-63bdad8a1a49?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1651&q=80"
        >
        </v-img>
        <h3>Shine like a summer sun</h3>
        <p>I see you shining baby</p>
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="8" sm="8" md="8" lg="8" offset="2">
        <v-carousel>
          <v-carousel-item
            v-for="(item, i) in items"
            :key="i"
            :src="item.src"
            reverse-transition="fade-transition"
            transition="fade-transition"
          ></v-carousel-item>
        </v-carousel>
      </v-col>
    </v-row>

    <v-row>
      <div id="app">
        <v-btn v-on:click="openModal">ログイン</v-btn>
        <v-btn v-on:click="moveToTop">新規登録</v-btn>
        <div id="overlay" v-show="showContent">
          <div id="content">
            <v-row>
              <v-col cols="12" md="12">
                <h2>Login</h2>
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
                  <v-btn class="mr-4 px-7" color="#f5851d" @click="login"
                    >Tell em!</v-btn
                  >
                  <v-icon color="red">mdi-crown</v-icon>
                  <p v-if="error" class="errors">{{ error }}</p>
                </form>
              </v-col>
            </v-row>
            <button v-on:click="closeModal">Close</button>
          </div>
        </div>
      </div>
    </v-row>
  </v-container>
</template>

<script>
import axios from "@/plugins/axios"
import firebase from "@/plugins/firebase";

export default {
  components: {},
  data() {
    return {
      email: "",
      name: "",
      point: "",
      password: "",
      passwordConfirm: "",
      show1: false,
      show2: false,
      items: ["画像1", "画像2"],
      showContent: false,
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
  computed: {
    user() {
      return this.$store.state.currentUser;
    }
  },
  methods: {
    login() {
      this.$store.dispatch("login", {
        email: this.email,
        password: this.password
      });
    },
    signup() {
      if (this.password !== this.passwordConfirm) {
        this.error = "※パスワードとパスワード確認が一致していません";
      }
      this.$store.commit("setLoading", false); //ローディングをonにする、一旦falseにした
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
              //追加
              this.$store.commit("setLoading", false); //ローディングをoffにする、ここで本来オフになる
              this.$store.commit("setUser", res.data); //promiseの値をstoreに入れる
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
    openModal: function() {
      this.showContent = true;
    },
    closeModal: function() {
      this.showContent = false;
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

<style lang="scss">
$main-color: #ce1a92;
$sub-color: #1e1381;
$accent-color: #6d1318;

.login-page {
  .login-title {
    text-align: center;
    font-size: 80px;
    font-family: 'Comic Sans MS';

    .login-title-first {
      color: $main-color;
    }
  }
  .login-subtitle {
    color: $sub-color;
  }
  .login-form-title {
    color: $accent-color;
  }
}

#title {
  display: inline-block;
  color: red;
  text-align: center;
  margin: 0 auto;
}
.introduction {
  margin-top: 50px;
}
.introduction h3 {
  text-align: center;
  margin: 0 auto;
  color: orange !important;
}
/* 指定がうまくいかない */
.v-img {
  text-align: center;
}
.v-window__container {
  border: solid 5px white;
}
/* モータルウィンドウ */
#overlay {
  /*　要素を重ねた時の順番　*/
  z-index: 1;

  /*　画面全体を覆う設定　*/
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);

  /*　画面の中央に要素を表示させる設定　*/
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
