<template>
  <v-app dark>
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
      <v-toolbar-title v-text="title" />
      <v-spacer />
    </v-app-bar>
    <v-content>
      <v-container>
        <nuxt />
      </v-container>
    </v-content>
    <v-footer :fixed="fixed" app>
      <span>&copy; 2020</span>
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
            icon: "mdi-apps",
            title: "Todos",
            to: "/"
          },
          {
            icon: "mdi-chart-bubble",
            title: "mypage",
            to: "/mypage"
          },
          {
            icon: "mdi-heart",
            title: "test",
            to: "/test"
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
