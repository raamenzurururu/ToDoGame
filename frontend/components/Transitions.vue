<template>
  <div id="app">
    <v-app id="inspire">
      <v-hover v-slot:default="{ hover }">
        <v-card class="mx-auto" color="black" max-width="600">
          <v-img
            :aspect-ratio="16 / 9"
            src="https://images.unsplash.com/photo-1519669556878-63bdad8a1a49?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3302&q=80"
          >
            <v-expand-transition>
              <div
                v-if="hover"
                class="d-flex transition-fast-in-fast-out pink darken-2 v-card--reveal display-3 white--text"
                style="height: 100%;"
              >
                ToDoGame
              </div>
            </v-expand-transition>
          </v-img>
          <v-card-text class="pt-6" style="position: relative;">
            <div class="font-weight-light grey--text title mb-2 text-center">
              やるべきことを終わらせる
            </div>
            <h3 class="display-1 font-weight-light orange--text mb-2">
              ゲーム感覚でタスク管理
            </h3>
            <div class="font-weight-light orange--text title text-center">
              Let's get started!
            </div>
          </v-card-text>
        </v-card>
      </v-hover>
    </v-app>
  </div>
</template>

<style scoped>
.v-card--reveal {
  align-items: center;
  bottom: 0;
  justify-content: center;
  opacity: 0.5;
  position: absolute;
  width: 100%;
}
</style>
