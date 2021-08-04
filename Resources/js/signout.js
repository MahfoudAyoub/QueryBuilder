var timerHandler;
var sessionTimeout = 0;
function SetReset(v) {
    clearTimeout(timerHandler);
    sessionTimeout = v;
}
sessionTimeout = "20";

function ResetTimeout() {
    sessionTimeout = "20";
}

var initsessionTimeout = sessionTimeout;

function DisplaySessionTimeout(alertBefore, sessionOutPath) {
    
    if (sessionTimeout > alertBefore && (sessionTimeout > 0)) {
        timerHandler = setTimeout("DisplaySessionTimeout(" + alertBefore + ", '" +  sessionOutPath + "')", 60000);
        sessionTimeout = sessionTimeout - 1;
    }
    else if (sessionTimeout <= alertBefore && (sessionTimeout > 0)) {
    timerHandler = setTimeout("DisplaySessionTimeout(" + alertBefore + ", '" + sessionOutPath + "')", 60000);
        sessionTimeout = sessionTimeout - 1;
    }
    else {
        window.location.href = sessionOutPath;
    }

}
