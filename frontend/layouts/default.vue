<template>
  <v-app class="app" dark>
    <Success />
    <Loading />
    <div>
      <Loading></Loading>
    </div>
    <v-navigation-drawer
      v-model="drawer"
      :mini-variant="miniVariant"
      :clipped="clipped"
      fixed
      app
    >
      <v-list>
        <v-list-item
          v-for="(item, i) in items"
          :key="i"
          :to="item.to"
          router
          exact
        >
          <v-list-item-action>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title v-text="item.title" />
          </v-list-item-content>
        </v-list-item>

        <v-list-item v-if="user" @click="logOutWindow = true">
          <v-list-item-action>
            <v-icon>mdi-key</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>ログアウト</v-list-item-title>
          </v-list-item-content>
          <v-dialog v-model="logOutWindow">
            <v-card>
              <v-card-title class="headline grey lighten-2" color="red">ログアウトしますか？</v-card-title>
              <v-btn color="orange" @click="logOut">はい</v-btn>
              <v-btn color="orange" @click="logOutWindow = false">いいえ</v-btn>
            </v-card>
          </v-dialog>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <v-app-bar class="tool-bar" :clipped-left="clipped" fixed app>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
      <v-toolbar-title class="pl-0">
        <router-link to="/user" class="toolbar-title"
          ><v-icon class="mb-2" size="38" color="yellow"
            >mdi-crown-outline</v-icon
          >ToDo<span class="title-first">Game</span></router-link
        >
      </v-toolbar-title>

      <v-toolbar-items class="page-link" v-if="user">
        <v-btn class="header-btn ml-1" @click="logOutWindow = true">
          <v-hover v-slot:default="{ hover }">
            <v-icon size="25px" color="orange" v-text="hover ? 'mdi-account-off' : 'mdi-account-hard-hat'">
            </v-icon>
          </v-hover>
        </v-btn>
      </v-toolbar-items>

      <!-- <v-toolbar-items class="page-link" v-if="user">
        <v-btn class="header-btn ml-1" @click="logOutWindow = true">
          <v-hover v-slot:default="{ hover }">
            <v-icon size="20px" color="orange" v-text="hover ? 'mdi-coffee-to-go' : 'mdi-coffee'">
            </v-icon>
          </v-hover>
        </v-btn>
      </v-toolbar-items> -->

      <v-spacer />
    </v-app-bar>
    <v-content>
      <v-container>
        <nuxt />
      </v-container>
    </v-content>
    <v-footer :fixed="fixed" app>
      <span>素材提供【Rド】様</span>
    </v-footer>
  </v-app>
</template>

<script>
import Loading from "@/components/Loading";
import Success from "@/components/Success";
import firebase from "@/plugins/firebase";
import axios from "@/plugins/axios";

export default {
  data() {
    return {
      clipped: false,
      drawer: false,
      fixed: false,
      miniVariant: false,
      right: false,
      rightDrawer: false,
      title: "ToDoGame",
      logOutWindow: false,
      logoutConfirm: false
    };
  },
  components: {
    Loading,
    Success,
  },
  computed: {
    user() {
      return this.$store.state.currentUser;
    },
    items() {
      if (this.currentUser) {
        return [
          {
            icon: "mdi-crown",
            title: "?",
            to: "/"
          },
          {
            icon: "mdi-star",
            title: "mypage",
            to: "/user"
          },
          {
            icon: "mdi-lock",
            title: "Reward",
            to: "/reward"
          }
        ];
      } else {
        return [
          {
            icon: "mdi-chess-king",
            title: "ログイン",
            to: "/login"
          },
          {
            icon: "mdi-chess-queen",
            title: "新規登録",
            to: "/signup"
          }
        ];
      }
    }
  },
  methods: {
    logOut() {
      this.logOutWindow = false;
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
$main-color: yellow;

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

.app {
  .toolbar-title {
    color: white;
    text-decoration: none;
    font-family: "sans-serif";
    font-size: 30px;
    font-weight: bold;
    .title-first {
      color: $main-color;
    }
  }

  .tool-bar {
    display: flex;
  }

  .page-link {
    justify-content: right;

    .page-link-title {
      padding-top: 15%;
    }

    .logout-btn {
      background-color: aquamarine;
      margin: 0 0 0 auto;
    }
  }

  .v-content_wrap {
    background-color: black !important;
  }
}
</style>
