/////////////////////////
// Hudobné Básne
//
// jednoduché aplikácie v SuperCollideri
// Fero Király, 2022
////////////////////////

// audio server boot
s.boot;

// nacita potrebne syntezatory
"assets/synthdefs.scd".loadRelative;

// nacita nejake nastavenie
"assets/setup.scd".loadRelative;

// obsauje cestu k suborom
~root

// obsahuje cestu k foldru so samplami
~sampleFolder


// nacita sample
(
	~sample = List.new; // vytvori prazdny zoznam (List)
	PathName.new(~path++"/ek").entries.do({ |v|
		// kazdy subor v adresari
		// nacitaj ho ako audio (Buffer) a pridaj do zoznamu (List)
		~sample.add(
			Buffer.read(s, v.fullPath.postln)
		);
	});
)

// kolko samplov je pripravenych
~sample.size

// takto vyzera prvy
~sample[0].plot

// test
// toto by malo prehrat nahodny sampel
Synth(\sample,[\buf, ~sample[20.rand]]);



////////////////////////////////////////////////

// defaultne nastavenia playera
(
	~tempo = 0.25;
	~rate = 1;
	~atk = 0.01;
	~rel = 0.01;
	~pan = 0;
	~amp = 1;
	~txt = " ";


// toto je player, ktory sa postara o vsetko
	Tdef(\player,{
				loop{
				~txt.do({ |v|
					var a = v.ascii;
					if(a >=97 && {a <= 122} ){
						Synth(\sample,[
							\buf, ~sample[a-97],
							\rate, ~rate,
							\atk, ~atk,
							\rel, ~rel,
							\pan, ~pan,
							\amp, ~amp
						]);
					};
					~tempo.wait;
				})
				} // loop
		});
)

////////////////////////////////////////////////////////////////////

// spustenie prehravaca
Tdef(\player).play

// obsah premenneh ~txt je transformovany na hudbu
~txt = "a b a b "
~txt = "axb a b "
~txt = "axby  b "

~txt = "s o l a r "


// a stop!
Tdef(\player).stop
