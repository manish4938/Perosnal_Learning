({
	 doAdd: function(component, event, helper)
     {
         var num1=component.get( 'v.num1');
         var num2=component.get( 'v.num2');
         component.set( 'v.output',pareseInt(num1)+pareseInt(num2));

	 },
     doSub: function(component, event, helper)
     {
         var num1=component.get( 'v.num1');
         var num2=component.get( 'v.num2');
         component.set( 'v.output',pareseInt(num1)-pareseInt(num2));
	 },
  doDiv: function(component, event, helper)
     {
         var num1=component.get( 'v.num1');
         var num2=component.get( 'v.num2');
         component.set( 'v.output',pareseInt(num1)/pareseInt(num2));
	 },

doMul: function(component, event, helper)
     {
         var num1=component.get( 'v.num1');
         var num2=component.get( 'v.num2');
         component.set( 'v.output',pareseInt(num1)*pareseInt(num2));
	 }
    
})