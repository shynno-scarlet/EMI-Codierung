//Library muss in Processing heruntergeladen werden
import g4p_controls.*;

GTextField textf;
GButton btn;
String text;

void setup(){
  size(800,600);
  background(33,36,39);
  
  textf = new GTextField(this, 50,50,700,400);
  textf.setPromptText("Text Input");
  
  btn = new GButton(this, 50, 500, 700, 50);
  btn.setText("Übersetzen");
  btn.setEnabled(true);
}

void draw(){

}

public void handleTextEvents(GEditableTextControl textcontrol, GEvent event){
  if(textcontrol == textf && GEvent.CHANGED == event){
    btn.setEnabled(true);
  }
}

public void handleButtonEvents(GButton button, GEvent event){
  if(button == btn && event == GEvent.CLICKED){ 
    text = textf.getText();
    String result;
    String urlencoded = "https://api.funtranslations.com/translate/morse.json?text=" + java.net.URLEncoder.encode(text);
    JSONObject json = null;
    try {
      json = loadJSONObject(urlencoded);
    } catch (Error e){}
    if(json != null){
      result = json.getJSONObject("contents").getString("translated").replace(".","•");
    } else {
      result = "Das Ratelimit für die Morse-Code API (5 Anfragen/Stunde) wurde überschritten.";
    }
      
    print(result);
    textf.setFocus(false); 
    textf.setText(result);
    btn.setEnabled(false);
  }
}
