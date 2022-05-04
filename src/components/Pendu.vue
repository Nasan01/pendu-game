<script>

import ScoreLog from "./ScoreLog.vue"

export default {

  props: ["theme"],

  components: {
    ScoreLog
  },

  data() {
    return {
      words: ["voiture", "vie", "table", "gouvernement", "ordinateur"],
      word: "",
      letter: "",
      found: new Set(),
      attempt: 5,
      score: 0,
      scoreLog: [],
    }
  },

  methods: {
    handleSubmit() {
      this.play(this.letter)
      this.letter = ""
      this.calculScore()
    },
    play(letter) {
      if(this.word.includes(letter)){
        this.found.add(letter)
      } else {
        this.attempt -= 1
        if(this.attempt <= 0)
          alert("Oupss! Game Over!")
      }
    },
    setWord() {
      let key = Math.round(Math.random() * this.words.length)
      this.word = this.words[key]
    },
    playAgain() {
      this.found.clear()
      this.setWord()
      this.attempt = 5
      this.scoreLog.push(this.score)
      this.score = 0
    },
    calculScore() {
      if(this.isWinner) {
        switch (this.attempt) {
          case 5:
            this.score = 100
            break;
          case 4:
            this.score = 80
            break;
          case 3:
            this.score = 60
            break;
          case 2:
            this.score = 40
            break;
          case 1:
            this.score = 20
            break;
        
          default:
            this.score = 0
            break;
        }
      }
    },
  },

  computed: {
    wordCached: {
      get() {
        let cached = ""
        for(let i=0; i < this.word.length; i++) {
          if(this.found.has(this.word[i])) {
            cached += this.word[i]
          } else  {
            cached += "*"
          }
        }
        return cached
      }
    },
    isReadOnly() {
      return this.letter.length >= 1
    },
    isGameEnd() {
      return this.attempt <= 0 || !this.wordCached.includes("*")
    },
    isWinner() {
      return !this.wordCached.includes("*")
    }
  },

  mounted() {
    this.setWord()
  },

}

</script>

<template>
  <div class="grid grid-cols-3 h-screen bg-gray-400">
    <div class="col-span-2 flex flex-col items-center justify-center" style="height: 80vh" v-if="isGameEnd">
      <div v-if="isWinner">
        <h1 class="text-8xl" :class="{'text-green-600': isWinner}">YOU WIN !!!!</h1>
      </div>
      <div v-else>
        <h1 class="text-8xl" :class="{'text-red-600': !isWinner}">GAME OVER !!</h1>
      </div>
      <p class="text-lg text-gray-600"><i>Thanks for playing !!!</i></p>
      <div class="text-right my-6">
        <button class="px-4 py-4 bg-gray-200 rounded-lg text-gray-400" @click="playAgain">Play Again !</button>
      </div>
    </div>
    <div class="col-span-2 flex flex-col items-center p-5 shadow-xl bg-slate-300 shadow-slate-800 m-2 rounded-md" v-else>
      <h1 class="text-4xl text-gray-700">Pendu-Game</h1>
      <div class="w-full text-7xl text-center text-slate-700 md:m-32">
        {{ wordCached }}
      </div>
      <div>
        <form @submit.prevent="handleSubmit">
          <div class="m-2 text-center">
            <input 
              type="text" 
              name="letter" 
              class="text-slate-300 bg-gray-400 text-center outline-none text-xl py-4" 
              v-model="letter" 
              :readonly="isReadOnly"
            />
          </div>
          <div class="text-center m-2">
            <button class="px-4 py-4 bg-gray-400 rounded-lg text-slate-300">submit</button>
          </div>
        </form>
      </div>
    </div>
    <div class="col-span-1 border-l-2 border-gray-600">
      <div class="flex flex-row justify-between py-16 px-2 text-4xl text-gray-800 bg-slate-300 rounded-md m-2 shadow-xl shadow-slate-800">
        <h3>Attempt : <span>{{ attempt }}</span></h3>
        <h3>Score : <span>{{ score }}</span></h3>
      </div>

      <ScoreLog :scores="scoreLog" />
    </div>
  </div>
</template>
