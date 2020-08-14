<template>
  <v-container class="login-page">
    <h1 class="login-title">ToDo<span class="login-title-first">Game</span></h1>
    <v-row>
      <v-col cols="12" sm="12" md="6" lg="6">
        <!-- 根拠のある言葉にしていく -->
        <h1 class="login-subtitle text-center">ToDoGameとは？</h1>
        <h2 class="login-explain">レベルアップ機能、報酬などであなたのモチベーションを高め、日々のやることをサクッと片付けるToDoアプリです。</h2>
        <div class="monster">
          <img src="../assets/mon_178.gif">
          <img class="mon" src="../assets/mon_176.gif">
        </div>
        <div v-if="user"></div>
        <div class="guest" v-else>
          <v-hover v-slot:default="{ hover }">
            <v-btn class="login-button" @click="guestLogin">
              <v-icon v-text="hover ? 'mdi-chess-rook' : ''"></v-icon>ゲストログイン
            </v-btn>
          </v-hover>
        </div>
        <h3 class="login-explain">人間は成長してこそ楽しさを感じる</h3>
        <img class="mon" src="../assets/mon_234.gif">
        <h3 class="login-explain">さらなる高みを目指して</h3>
        <img class="mon" src="../assets/mon_223.gif">
        <h3 class="login-explain">やるべきことをゲーム化して終わらせよう！</h3>
        <img class="mon" src="../assets/mon_239.gif">
        <h3 class="login-explain">レベルを５０にして伝説の剣を手に入れよう</h3>
        <img class="mon" src="../assets/mon_224.gif">
      </v-col>
      <v-col v-if="user" cols="12" sm="12" md="6" lg="6">
        <v-icon class="mb-2" size="80">mdi-chess-king</v-icon>
        <div class="instead-of-form">
          <p>※ここに居てはダメだ</p>
          <p>※ToDoを終わらせてのんびりしよう.</p>
        </div>
      </v-col>
      <v-col
        class="login-button-wrapper"
        v-else
        cols="12"
        sm="12"
        md="6"
        lg="6"
      >
        <form>
          <h1 id="login-signup" class="login-form-title text-center">
            新規登録はこちら
          </h1>
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
          <p v-if="error" class="errors">{{ error }}</p>
        </form>
        <v-hover v-slot:default="{ hover }">
          <v-btn class="login-button" @click="signup">
            <v-icon v-text="hover ? 'mdi-chess-king' : ''"></v-icon>
            GO GAME
          </v-btn>
        </v-hover>
      </v-col>
    </v-row>

    <v-row class="introduction">
      <v-col class="sub-introduction main" cols="12" sm="12" md="12" lg="12">
        <h3>ToDo + Game =</h3>
        <h1>YOU</h1>
      </v-col>
    </v-row>

    <v-row class="introduction md-0">
      <v-col class="sub-introduction" cols="12" sm="12" md="4" lg="4">
        <img class="" src="../assets/mon_260.gif" />
        <h3>毎日続ける</h3>
        <h3 class="login-explain">TP(TaskPoint)は報酬の開放に使用できるぞ！</h3>
      </v-col>

      <v-col class="sub-introduction" cols="12" sm="12" md="4" lg="4">
        <img class="" src="../assets/mon_070.gif" />
        <h3>それが成長へのコツ</h3>
        <h3>
          やることを完了させるたびに経験値が溜まっていく。より高みを。そしてレベルが高いといいことが？
        </h3>
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="12" sm="12" md="12" lg="10">
        <v-carousel height="100%">
          <v-carousel-item
            v-for="(item, i) in items"
            :key="i"
            :src="item.src"
          ></v-carousel-item>
        </v-carousel>
      </v-col>
    </v-row>

    <v-hover v-slot:default="{ hover }">
      <div v-if="user"></div>
      <v-btn v-else class="bottom-btn" @click.stop="dialog = true">
        <v-icon v-text="hover ? 'mdi-chess-queen' : ''"></v-icon>
        ログイン
      </v-btn>
    </v-hover>
    <v-hover v-slot:default="{ hover }">
      <div v-if="user"></div>
      <v-btn v-else class="bottom-btn" @click="moveToTop">
        <v-icon v-text="hover ? 'mdi-chess-knight' : ''"></v-icon>
        新規登録
      </v-btn>
    </v-hover>
    <!-- <v-btn color="primary" dark @click.stop="dialog = true">
      open dialog
    </v-btn> -->
    <v-dialog content-class="dialog" v-model="dialog" max-width="60%">
      <v-card>
        <v-card-title class="headline"><h3>Login</h3></v-card-title>
        <v-card-text>
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
            <v-hover v-slot:default="{ hover }">
              <v-btn class="dialog-btn" @click="login">
                <v-icon v-text="hover ? 'mdi-chess-queen' : ''"></v-icon>
                GO GAME
              </v-btn>
            </v-hover>
            <p v-if="error" class="errors">{{ error }}</p>
          </form>
        </v-card-text>
      </v-card>
    </v-dialog>
    <!-- <form>
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
    </form> -->
  </v-container>
</template>

<script>
import axios from "@/plugins/axios";
import firebase from "@/plugins/firebase";
import Pipo from "@/assets/pipo-pic003.jpg";
import Forest from "@/assets/bg1.jpg";

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
      dialog: false,
      items: [
        {
          src: Pipo
        },
        {
          src: Forest
        }
      ],
      showContent: false,
      error: ""
    };
  },
  computed: {
    user() {
      return this.$store.state.currentUser;
    }
  },
  methods: {
    openModal: function() {
      this.showContent = true;
    },
    closeModal: function() {
      this.showContent = false;
    },
    signup() {
      if (this.password !== this.passwordConfirm) {
        this.error = "※パスワードとパスワード確認が一致していません";
        return
      }
      if (this.name == "") {
        this.error = "名前を入力してください";
        return
      }
      this.$store.commit("setLoading", false);
      firebase
        .auth()
        .createUserWithEmailAndPassword(this.email, this.password)
        .then(res => {
          const user = {
            email: res.user.email,
            name: this.name,
            uid: res.user.uid
          };
          this.$store.commit("setLoading", true);
          axios
            .post("/v1/users", {
              user
            })
            .then(res => {
              this.$store.commit("setLoading", false); 
              this.$store.commit("setUser", res.data); //promiseの値をstoreに入れる
              this.$store.commit("setNotice", {
                status: true,
                message: this.name + "さん、新規登録が完了しました！"
              });
              setTimeout(() => {
                this.$store.commit("setNotice", {});
              }, 2000);
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
      this.$store.commit("setLoading", true);
      firebase
        .auth()
        .signInWithEmailAndPassword(this.email, this.password)
        .then(() => {
          this.$store.commit("setNotice", {
            status: true,
            message: "ログインしました"
          });
          setTimeout(() => {
            this.$store.commit("setLoading", false);
          }, 1000);
          setTimeout(() => {
            this.$store.commit("setNotice", {});
          }, 2000);
          this.$router.push("/user");
        })
        .catch(error => {
          console.log(error);
          this.error = (code => {
            switch (code) {
              case "auth/user-not-found":
                return "メールアドレスが間違っています";
              case "auth/wrong-password":
                return "※パスワードが正しくありません";
              default:
                return "※メールアドレスとパスワードをご確認ください";
            }
          })(error.code);
        });
    },
    guestLogin() {
      this.$store.commit("setLoading", true);
      firebase
        .auth()
        .signInWithEmailAndPassword("test@gmail.com", "aaaaaa")
        .then(() => {
          this.$store.commit("setNotice", {
            status: true,
            message: "ログインしました"
          });
          setTimeout(() => {
            this.$store.commit("setLoading", false);
          }, 1000);
          setTimeout(() => {
            this.$store.commit("setNotice", {});
          }, 2000);
          this.$router.push("/user");
        })
        .catch(error => {
          console.log(error);
          this.error = (code => {
            switch (code) {
              case "auth/user-not-found":
                return "メールアドレスが間違っています";
              case "auth/wrong-password":
                return "※パスワードが正しくありません";
              default:
                return "※メールアドレスとパスワードをご確認ください";
            }
          })(error.code);
        });
    },
    moveToTop() {
      const duration = 1000; // 移動速度（1秒で終了）
      const interval = 25; // 0.025秒ごとに移動
      const step = -window.scrollY / Math.ceil(duration / interval); // 1回に移動する距離
      const timer = setInterval(() => {
        window.scrollBy(0, step); // スクロール位置を移動

        if (window.scrollY <= 0) {
          clearInterval(timer);
          const title = document.getElementById("login-signup");
          const check = function(name) {
            title.classList.add(name);
          };
          setTimeout(check, 250, "checked");
        }
      }, interval);
    }
  }
};
</script>

<style lang="scss">
$main-color: yellow !important;
$sub-color: #dd8b10;
$accent-color: red;

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



@mixin explain {
  color: $sub-color;
  font-family: sans-serif;
  margin-bottom: 10px;
}

.login-page {
  .mon {
    width: 20%;

    @include sp {
      width: 20%;
    }
  }
  .monster {
    text-align: center;
  }

  .login-title {
    text-align: center;
    font-size: 70px;
    font-family: sans-serif;
    margin-bottom: 0px;

    .login-title-first {
      color: $main-color;
    }
  }
  .login-subtitle,
  .login-form-title {
    @include explain;
  }
  .login-explain {
    text-align: center;
    margin-bottom: 30px;
  }
  @mixin login-bottom-btn {
    background-color: black !important;
    border: 2px solid white;
    color: white;
    display: inline-block;
    width: 80%;
    margin: 15px;
    font-weight: bold;
  }
  .login-button-wrapper {
    .login-button {
      background-color: black !important;
      border: 2px solid white;
      color: white;
      width: 100%;
    }
    .skull {
      padding-left: 40%;
    }
    .instead-of-form {
      border: 2px white solid;
      padding-top: 20px;
    }
  }
  .introduction {
    margin: 100px auto 50px;

    img {
      display: block;
      margin: 0 auto 30px;
    }
    .sub-introduction {
      text-align: center;
    }
    .main {
      border: 1px white solid;
    }
  }
  h1 {
    text-align: center;
    margin-top: 30px;
  }
  .mdi-chess-queen {
    color: black !important;
  }

  .mdi-chess-knight {
    color: black !important;
  }

  .login-button {
    &:hover {
      border: 2px solid yellow;
      color: yellow;
    }
  }
  .checked {
    color: red;
  }
  .login-button-wrapper {
    text-align: center;
    .bottom-btn {
      @include login-bottom-btn;
      &:hover {
        border: 2px solid white;
        color: white;
      }
    }
  }
  .dialog {
    .bottom-btn {
      @include login-bottom-btn;
      &:hover {
        border: 2px solid white;
        color: white;
      }
    }
  }
  .errors {
    color: $accent-color;
  }
}
.v-window__container {
  border: solid 5px white;
}

.dialog-btn {
  background-color: black;
  border: 2px solid $main-color;
  color: $main-color !important;
  display: inline-block;
  margin: 15px;
  width: 45%;
  font-weight: bold;
  .mdi-chess-queen {
    color: black !important;
  }
  &:hover {
    border: 2px solid white;
    color: white;
  }
}
.headline {
  color: $sub-color;
}

.guest {
  text-align: center;
  margin-top: 59px;
  .guest-btn {
    &:hover {
      border: 2px solid yellow;
      color: yellow;
    }
    @include sp {
      font-size: 25px;
      width: 80% !important;
      height: 70px !important;
    }
  }
}


</style>
