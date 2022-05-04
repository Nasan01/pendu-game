<script>

	export default {
		props: ["scores"],
		computed: {
			reverseScores() {
				return this.scores.reverse()
			}
		}
	}

</script>

<template>
	<div class="flex flex-col text-gray-700 max-h-96 p-1 overflow-scroll">
		<h1 class="text-xl m-3 text-slate-300"><i>Your Last Game Score : </i></h1>
		<div 
			class="flex flex-row justify-between mx-2 my-1 p-5 bg-slate-300 shadow-lg shadow-slate-700 rounded-md" 
			v-for="(score, index) in reverseScores" 
			:key="index"
		>
			<p>(you)</p>
			<p>score : {{ score }}</p>
		</div>
	</div>
</template>