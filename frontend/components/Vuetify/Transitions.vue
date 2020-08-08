<template>
  <div id="app">
    <v-app id="inspire">
      <v-row>
        <v-col cols="4"></v-col>
        <v-hover v-slot:default="{ hover }">
          <v-card class="mx-auto" color="black" max-width="600">
            <v-img :aspect-ratio="16 / 9" src="bg1.jpg">
              <v-expand-transition>
                <div
                  v-if="hover"
                  class="d-flex transition-fast-in-fast-out green darken-2 v-card--reveal display-3 white--text"
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
              <h3 class="display-1 font-weight-light green--text mb-2">
                ゲーム感覚でタスク管理
              </h3>
              <div class="font-weight-light green--text title text-center">
                Let's get started!
              </div>
            </v-card-text>
          </v-card>
        </v-hover>
      </v-row>
    </v-app>
    <!-- 二個目 -->
    <v-app id="inspire">
      <v-row>
        <v-col cols="4"></v-col>
        <v-hover v-slot:default="{ hover }">
          <v-card class="mx-auto" color="black" max-width="600">
            <v-img :aspect-ratio="16 / 9" src="pipo-pic002.jpg">
              <v-expand-transition>
                <div
                  v-if="hover"
                  class="d-flex transition-fast-in-fast-out blue darken-2 v-card--reveal display-3 white--text"
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
              <h3 class="display-1 font-weight-light blue--text mb-2">
                冒険するような気持ちで
              </h3>
              <div class="font-weight-light blue--text title text-center">
                Let's get started!
              </div>
            </v-card-text>
          </v-card>
        </v-hover>
      </v-row>
    </v-app>
    <!-- 三個目 -->
    <v-app id="inspire">
      <v-row>
        <v-col cols="4"></v-col>
        <v-hover v-slot:default="{ hover }">
          <v-card class="mx-auto" color="black" max-width="600">
            <v-img :aspect-ratio="16 / 9" src="pipo-pic003.jpg">
              <v-expand-transition>
                <div
                  v-if="hover"
                  class="d-flex transition-fast-in-fast-out white darken-2 v-card--reveal display-3 black--text"
                  style="height: 100%;"
                >
                  ToDoGame
                </div>
              </v-expand-transition>
            </v-img>
            <v-card-text class="pt-6" style="position: relative;">
              <div class="font-weight-light grey--text title mb-2 text-center">
                報酬をその手に
              </div>
              <h3 class="display-1 font-weight-light white--text mb-2">
                報酬を獲得する楽しさを
              </h3>
              <div class="font-weight-light white--text title text-center">
                Let's get started!
              </div>
            </v-card-text>
          </v-card>
        </v-hover>
      </v-row>
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
