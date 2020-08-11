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
      </v-list>
    </v-navigation-drawer>
    <v-app-bar :clipped-left="clipped" fixed app>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
      <v-toolbar-title class="pl-0">
        <router-link to="/" class="toolbar-title"><v-icon class="mb-2" size="38" color=yellow>mdi-crown-outline</v-icon>ToDo<span class="title-first">Game</span></router-link>
      </v-toolbar-title>
      <v-spacer />
    </v-app-bar>
    <v-content>
      <v-container>
        <nuxt />
      </v-container>
    </v-content>
    <v-footer :fixed="fixed" app>
      <span>ToDo + Game = You</span>
    </v-footer>
  </v-app>
</template>

<script>
import Loading from "@/components/Loading";
import Success from "@/components/Success";

export default {
  data() {
    return {
      clipped: false,
      drawer: false,
      fixed: false,
      miniVariant: false,
      right: false,
      rightDrawer: false,
      title: "ToDoGame"
    };
  },
  components: {
    Loading,
    Success
  },
  computed: {
    user() {
      return this.$store.state.currentUser;
    },
    items() {
      if (this.user) {
        return [
          {
            icon: "mdi-crown",
            title: "ToDoGame",
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
            icon: "mdi-apps",
            title: "ログイン",
            to: "/login"
          },
          {
            icon: "mdi-chart-bubble",
            title: "新規登録",
            to: "/signup"
          }
        ];
      }
    }
  }
};
</script>

<style lang="scss">
$main-color: deeppink;

.app {
  .toolbar-title {
    color: white;
    text-decoration: none;
    font-family: sans-serif;
    font-size: 30px;
    font-weight: bold;
    .title-first {
      color: $main-color;
    }
  }
  .v-content_wrap {
    background-color: black !important;
  }
}

</style>
