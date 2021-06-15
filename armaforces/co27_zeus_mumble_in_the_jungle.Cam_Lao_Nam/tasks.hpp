
class Patrol {
	title = "Patrol";
	marker = "task_patrol";
	description = "";
	icon = "boat";

	conditionEventsSuccess[] = {"SurviveAmbushDone", "UnloadSuppliesDone", "BuildFobDone"};
	conditionEventsSuccessRequired = 3;

	onSuccessEvents[] = {"PatrolDone"};
};
class StartPatrol {
	parentTask = "Patrol";
	initialState = "ASSIGNED";
	marker = "port";

	conditionCodeSuccess = "missionNamespace getVariable ['patrolStarted', false]";

	title = "Rozpocznijcie patrol";
	description = "Przed wyruszeniem na patrol należy zebrać drużynę. Gdy już będziecie gotowi wsiądźcie do łodzi i płyńcie na północ.";
};
class SurviveAmbush {
	parentTask = "Patrol";
	initialState = "ASSIGNED";

	createdShowNotification = "true";
	conditionCodeShow = "missionNamespace getVariable ['ambushStarted', false]";
	conditionCodeSuccess = "missionNamespace getVariable ['ambushSurvived', false]";

	onSuccessEvents[] = {"SurviveAmbushDone"};

	title = "Odeprzyjcie atak NVA";
	description = "Patrol rzeczny jest niebezpieczny, odeprzyjcie atak NVA.";
	icon = "defend";
};
class UnloadSupplies {
	parentTask = "Patrol";
	marker = "task_unloadsupplies";

	createdShowNotification = "true";
	conditionCodeSuccess = "[] call vet_fnc_suppliesUnloaded";

	onSuccessEvents[] = {"UnloadSuppliesDone"};

	title = "Wyładujcie zapasy";
	description = "Aby zbudować FOB musicie dostarczyć zapasy przechowywane w łodziach. Wyładujcie je na brzeg a następnie dostarczcie na miejsce budowy FOBa.";
	icon = "land";
};
class BuildFOB {
	parentTask = "Patrol";
	marker = "fob";
	initialState = "ASSIGNED";

	createdShowNotification = "true";
	conditionEventsShow[] = {"UnloadSuppliesDone"};
	conditionCodeSuccess = "missionNamespace getVariable ['fobBuilt', false]";

	onSuccessEvents[] = {"BuildFobDone"};

	title = "Utwórzcie FOB";
	description = "Aby wybudować FOBa musicie dostarczyć zapasy do wskazanej lokalizacji. HQ zrzuciło Blu82 aby zrobić przestrzeń na fortyfikacje.";
	icon = "container";
};


class SearchAndDestroy {
	initialState = "ASSIGNED";
	marker = "nva_camp";

	createdShowNotification = "true";

	conditionEventsShow[] = {"BuildFobDone"};
	conditionEventsSuccess[] = {"TunnelDone"};

	onSuccessEvents[] = {"SearchAndDestroyDone"};

	title = "Znajdźcie i zniszczcie zapasy NVA";
	description = "";
	icon = "destroy";
};
class Tunnel {
	parentTask = "SearchAndDestroy";
	initialState = "ASSIGNED";

	owners[] = {"zeus", "zulu", "charlie"};

	createdShowNotification = "true";

	conditionCodeShow = "missionNamespace getVariable ['tunnelFound', false]";
	conditionCodeSuccess = "missionNamespace getVariable ['armoryDestroyed', false]";

	onSuccessEvents[] = {"TunnelDone"};

	title = "Tunel";
	description = "NVA wykorzystuje tunele to przemieszczania się oraz składowania w nich zapasów. Przeszukajcie je i zniszczcie każde zapasy które tam znajdziecie.";
	icon = "search";
};
class Defend {
	parentTask = "SearchAndDestroy";
	initialState = "ASSIGNED";

	createdShowNotification = "true";

	owners[] = {"zeus", "zulu", "alpha", "bravo"};

	conditionCodeShow = "missionNamespace getVariable ['tunnelFound', false]";
	conditionEventsSuccess[] = {"TunnelDone"};

	title = "Zabezpieczcie obóz";
	description = "Zabezpieczajcie perymetr obozu do czasu aż szczury tunelowe skończą sprawdzać tunele";
	icon = "defend";
};


class RTB {
	initialState = "ASSIGNED";

	createdShowNotification = "true";

	conditionEventsShow[] = {"SearchAndDestroyDone"};

	title = "Wróćcie do FOB Gorilla";
	description = "Wykonaliście swoje zadanie wróćcie do FOBa.";
};
