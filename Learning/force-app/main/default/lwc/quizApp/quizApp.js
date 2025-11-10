import { LightningElement } from 'lwc';

export default class QuizApp extends LightningElement {
 
    selected={};//for storing answers   
    correctAnswers=0;
    isSubmitted = false;//to show number of correct answer
    //Set Of Questions with correct answer
    myQuestions=[
        {
            id:"Question1",
            question:"Which of the following is not a template loop?",
            answers:{
                  a:"for : each",
                  b:"iterator",
                  c:"map loop"
            },
            correctAnswer:"c"
        },
        {
            id:"Question2",
            question:"Which of the following is Invalid in LWC Folder?",
            answers:{
                  a:".svg",
                  b:".apex",
                  c:".js"
            },
            correctAnswer:"b"
        },
        {
            id:"Question3",
            question:"Which of the following is not a directive?",
            answers:{
                  a:"for : each",
                  b:"if: true",
                  c:"@track"
            },
            correctAnswer:"c"
        }
    ];
     
   get allNotSelected(){
        return !(Object.keys(this.selected).length === this.myQuestions.length)
    }

   get isScoreFull(){
        return `slds-text-heading_large ${this.myQuestions.length === this.correctAnswers? 
               'slds-text-color_success': 'slds-text-color_error'}`
    }d
    changeHandler(event){
        console.log("name",event.target.name);
        console.log("value",event.target.value);
        //const name=event.target.name;
        //const value=event.target.value;
        const {name,value} = event.target;
        this.selected = {...this.selected, [name] : value}; // i.e this.selected = {"Questions1":"a"}.......>
    } 

    submitHandler(event){
        event.preventDefault();
        let correct = this.myQuestions.filter(item=>this.selected[item.id] === item.correctAnswer);
        this.correctAnswers=correct.length;
        this.isSubmitted=true;
    }

    resetHandler(event){
        this.selected ={};
        this.correctAnswers=0;
    }


}