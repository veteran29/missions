
if (!hasInterface) exitWith {true};

// Select "Briefing" by default on the map screen
[] spawn {
    disableSerialization;
    private ["_display"];
    waitUntil {
        _display = uiNamespace getVariable ["RscDiary", displayNull];
        !isNull _display
    };

    sleep 1;

    private _diaryList = (_display displayCtrl 1001);
    _diaryList lnbSetCurSelRow 1; // Briefing

    private _ca_diaryIndex = (_display displayCtrl 1002);
    _ca_diaryIndex lnbSetCurSelRow 1; // Mission
};

// player createDiaryRecord [
//     "Diary",
//     [localize "STR_A3_Diary_Signal_title", localize "STR_VN_BRIEFING_CO04_SIGNAL"]
// ];


player createDiaryRecord [
	"Diary",
	[
		localize "STR_A3_Diary_Execution_title", 
		"
        <br/>1. Rozpoczęcie podróży z <marker name='port'>tymczasowego portu</marker> umieszczonego w niedawno zdobytej bazie NVA ""Oscar Eight""
        <br/>2. Dostarczenie zapasów na <marker name='task_unloadsupplies'>brzeg</marker> na południowy-wschód od Dao Trai 
        <br/>3. Utworzenie FOB Gorilla na <marker name='fob'>wskazanej pozycji</marker>
        <br/>4. Znalezienie i zniszczenie zapasów NVA w <marker name='nva_camp'>Giua Ho</marker>
        <br/>5. Powrót do <marker name='fob'>FOB Gorilla</marker>
        "
	]
];

// player createDiaryRecord [
//     "Diary", ["Tactical", localize "STR_VN_BRIEFING_CO04_TACTICAL"]
// ];

player createDiaryRecord [
    "Diary", [
		localize "STR_A3_Diary_Mission_title", 
		"5 Dywizja Piechoty została wysłana na misję przetarcia szlaku rzecznego, likwidacji zapasów NVA oraz utworzenia wysuniętej placówki w zachodnim Laosie."
	]
];

player createDiaryRecord [
    "Diary", [
        localize "STR_A3_Diary_Situation_title", 
        "
        <img image='\vn\missions_f_vietnam\data\img\m04\situation.jpg' width='380' height='190'/>
        <br/>NVA używa <marker name='trail_1'>szlaku Ho Chi Minh</marker> do przewożenia amunicji oraz ciężkiego sprzętu.
        <br/>Wywiad ustalił że NVA przechowuje spore zapasy amunicji w obozie <marker name='nva_camp'>Giua Ho</marker>
        "
    ]
];
