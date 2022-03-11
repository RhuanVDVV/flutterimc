
import 'package:flutter/material.dart';




void main ( ) => runApp(
  const MaterialApp(
    home:Home(),
    debugShowCheckedModeBanner: false,
  ),
);


class Pessoa {
  late String genero;
  late double peso;
  late double altura;
}
enum Genero { masculino, feminino }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  
  @override
  _HomeState createState() => _HomeState();

}
class _HomeState extends State<Home>{
  Pessoa pessoa = Pessoa();
  Genero? genero = Genero.masculino;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController weightController = TextEditingController();
TextEditingController heightController = TextEditingController();
String result = '';
String resultadog ='';
@override
void initState(){
  super.initState();
  resetFields();
}
void resetFields(){
 weightController.text ='';
 heightController.text ='';
 setState((){
 late String result = 'Informe seus Dados';
   
 });
}
void calculateImc(Pessoa pessoa){
  var genero = pessoa.genero;
  var peso = pessoa.peso;
  var altura = pessoa.altura;
  resultadog="";
  
   double imc = peso / (altura * altura);
   setState ((){
   
    
   if(genero == Genero.masculino.toString())
   {
     if (imc < 20.7){
     
     resultadog = "Abaixo do peso";
     result = "IMC= ${imc.toStringAsPrecision(2)}\n " + resultadog.toString();
     buildTextResult(resultadog);
     
    }
    else
    if (imc <26.4){
     resultadog = "Peso ideal";
     result = "IMC= ${imc.toStringAsPrecision(2)}\n " + resultadog.toString();
     buildTextResult(resultadog);

    }
    else
    if (imc <27.8){
     resultadog = "Levemente acima do peso";
     result = "IMC= ${imc.toStringAsPrecision(2)}\n " + resultadog.toString();
     buildTextResult(resultadog);

    }
    else
    if (imc <31.1){
     resultadog = "Obesidade Grau I";
     result = "IMC= ${imc.toStringAsPrecision(2)}\n " + resultadog.toString();
     buildTextResult(resultadog);
 
    }
    else
     if (imc <40.0){
     resultadog = "Obesidade Grau II";
     result = "IMC= ${imc.toStringAsPrecision(2)}\n " + resultadog.toString();
     buildTextResult(resultadog);

     }
     else
     if (imc >= 40.0){
     resultadog = "Obesidade Grau III";
     result = "IMC= ${imc.toStringAsPrecision(2)}\n " + resultadog.toString();
     buildTextResult(resultadog);
      
     }
     result = "IMC= ${imc.toStringAsPrecision(2)}\n " + resultadog.toString();
     
   }
   if(genero == Genero.feminino.toString()){
     if (imc < 19.1){
     resultadog = "Abaixo do peso";
     result = "IMC= ${imc.toStringAsPrecision(2)}\n " + resultadog.toString();
     buildTextResult(resultadog);
   }
   else
   if (imc <25.9){
     resultadog = "Peso ideal";
     result = "IMC= ${imc.toStringAsPrecision(2)}\n " + resultadog.toString();
     buildTextResult(resultadog);

   }
   else
   if (imc <27.4){
     resultadog = "Levemente acima do peso";
     result = "IMC= ${imc.toStringAsPrecision(2)}\n " + resultadog.toString();
     buildTextResult(resultadog);

   }
   else
   if (imc <32.4){
     resultadog = "Obesidade Grau I";
     result = "IMC= ${imc.toStringAsPrecision(2)}\n " + resultadog.toString();
     buildTextResult(resultadog);

   }
   else
   if (imc <40.0){
     resultadog = "Obesidade Grau II";
     result = "IMC= ${imc.toStringAsPrecision(2)}\n " + resultadog.toString();
     buildTextResult(resultadog);

   }
   else
   if (imc >= 40.0){
     resultadog = "Obesidade Grau III";
     result = "IMC= ${imc.toStringAsPrecision(2)}\n " + resultadog.toString();
     buildTextResult(resultadog);

   }
   
   result = "IMC= ${imc.toStringAsPrecision(2)}\n" + resultadog.toString();
   }
   
   });
  
}
@override 
Widget build (BuildContext context){
  return Scaffold(appBar: buildAppBar(),
  backgroundColor: Colors.white,
  body:SingleChildScrollView(padding:const EdgeInsets.all(20.0),child:buildForm()));
}
AppBar buildAppBar(){
  return AppBar(
    title:const Text('Calculadora de IMC'),
    backgroundColor: Colors.blue,
    actions:<Widget>[
      IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: (){
          resetFields();
        },
        )
    ],
  );

  
}
Form buildForm(){
   
  return Form(
    key: formKey,
    child:Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildTextFormField(
          label:"Peso (kg)",
          error:"Insira seu peso!",
          controller: weightController),
          buildTextFormField(
            label:"Altura (cm)",
            error:"Insira uma altura!",
            controller: heightController),
            ListTile(title: const Text('Masculino'),
            leading: Radio<Genero>(value:Genero.masculino,
            groupValue: genero,
            onChanged: (Genero? value){
              setState((){
                genero = value;
              });
            },
            ),
            ),
            ListTile(
              title: const Text('Feminino'),
              leading: Radio<Genero>(value:Genero.feminino,
              groupValue: genero,
              onChanged: (Genero? value){
                setState(() {
                  genero =value;
                });
              },
              ),
              
              ),
             
              
              
               buildCalculateButton(),
              buildTextResult(resultadog),
              

          
      ],
    ),
  );
}
Padding buildCalculateButton(){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 36.0),
    child:ElevatedButton(onPressed: (){
      if (formKey.currentState!.validate()){
        resultadog = "";
        Pessoa pessoa = Pessoa();
        pessoa.genero = genero.toString();
        pessoa.altura = double.parse(heightController.text)/100.0;
        pessoa.peso = double.parse(weightController.text);
        
        calculateImc(pessoa);
      }
    },
    child:const Text('CALCULAR', style: TextStyle(color:Colors.white)),
    ),
  );
}

Padding buildTextResult(String resultado){  
  if(resultadog == "Abaixo do peso"){
   return Padding(padding: const EdgeInsets.symmetric(vertical: 36.0),
  child: Text(result,textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color:Colors.amber),), 
  );
  }
  else if (resultadog == "Peso ideal"){
    return Padding(padding: const EdgeInsets.symmetric(vertical: 36.0),
  child: Text(result,textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.green),), 
  );
  }
  else if(resultadog == "Levemente acima do peso"){
    return Padding(padding: const EdgeInsets.symmetric(vertical: 36.0),
  child: Text(result,textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color:Colors.yellow),), 
  );
  }
  else if (resultadog=="Obesidade Grau I"){
    return Padding(padding: const EdgeInsets.symmetric(vertical: 36.0),
  child: Text(result,textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.orange),), 
  );
  }
  else if(resultadog=="Obesidade Grau II"){
    return Padding(padding: const EdgeInsets.symmetric(vertical: 36.0),
  child: Text(result,textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.deepOrange),),);
  
  }
  else if(resultadog =="Obesidade Grau III"){
    return Padding(padding: const EdgeInsets.symmetric(vertical: 36.0),
  child: Text(result,textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Color.fromARGB(255, 255, 17, 0)),), 
  );
  }
  return Padding(padding: const EdgeInsets.symmetric(vertical: 36.0),
  child: Text(result,textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Color.fromARGB(255, 255, 17, 0)),), 
  );
  }

TextFormField buildTextFormField(
  {required TextEditingController controller, required String error, required String label})
  {
  return TextFormField(
    keyboardType: TextInputType.number,
    decoration: InputDecoration(labelText:label),
    controller:controller,
    validator:(text){
      return text!.isEmpty ? error: null;
    },
    );
}
}
