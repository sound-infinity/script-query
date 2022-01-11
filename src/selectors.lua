return {
	CARDLIST = '<main>.-<div.-class="releases".->(.+)</div>.-</main>',
	CARD = '<div.-class="release%-card.-".->.-</a>.-</div>',
	CARD_TITLE = ".-release%-title.->(.-)</",
	CARD_DESCRIPTION = ".-release%-description.->.-<p>(.-)</",
	CARD_DOWNLOADURL = '.-download%-button.-href.-"(.-)"',
	BUTTON_DOWNLOADURL = '.-btnDownload.-href.-"(.-)"',
}
