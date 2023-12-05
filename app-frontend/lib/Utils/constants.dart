// use 127.0.0.1 when testing with a browser and 10.0.2.2 when testing with the emulator or your IP Address if using a physical device
const String server = "http://10.0.2.2:8080";
// const String server = "http://127.0.0.1:8080";
// const String server = "http://{YOUR_IP_ADDRESS}:8080";

const Map<String, String> onboardingTexts = {
  "ramped":
      "Welcome to the Ramped Fitness Test, In this workout your aim is to cycle for as long as possible, you will begin at a nice cruising pace.\n\nEvery 30 seconds the difficulty will increase, making it harder to continue to cycle. This is a test of both your strength and endurance so make sure to pace yourself to have the best possible chance of clearing all the difficulties.\n\nOnce you reach your limit, press the ‘Finish Workout’ button towards the bottom of the screen to end the workout and view your results. Good Luck!\n\n",
  "strength":
      "Welcome to the Strength Training Workout, In this workout you will help build strength in your leg muscles.\n\nThe bike will be set up with a higher resistance and you will ride at a lower cadence to help build this strength in your leg muscles.\n\nThis workout has a set time limit so try to ride for the entire time. If you reach your limit or wish to exit the workout early, press the ‘Finish Workout’ button towards the bottom of the screen to end the workout and view your results. Good Luck!\n\n",
  "endurance":
      "Welcome to the Endurance Training Workout, In this workout you will aim to test your endurance as you continue to cycle for an extended period.\n\nThe bike will be configured with a lower resistance, but you will need to cycle at a higher cadence.\n\nThis workout has a set time limit so try to ride for the entire time. If you reach your limit or wish to exit the workout early, press the ‘Finish Workout’ button towards the bottom of the screen to end the workout and view your results. Good Luck!\n\n",
  "threshold":
      "Welcome to the Anaerobic Threshold Training Workout, In this workout you will need to navigate through periods of high and low intensity cycling.\n\nYou will begin at a cruising pace and will then proceed to a higher difficulty of cycling conditions where it will remain for 30 seconds. After the 30 second sprint the difficulty will decrease, and you will have a chance to recovery briefly. After a minute, the cycling difficulty will increase again, and this process will repeat until the workout time limit is reached.\n\nTry to ride for the entire time. If you reach your limit or wish to exit the workout early, press the ‘Finish Workout’ button towards the bottom of the screen to end the workout and view your results. Good Luck!\n\n"
};

const Map<String, String> workoutNames = {
  "ramped": "Ramped Workout",
  "strength": "Strength Training",
  "endurance": "Endurance Training",
  "threshold": "Anaerobic Training"
};
const String google_api_key = "YOUR_API_KEY";
