import 'dart:isolate';
import '../controllers/pet_controllers.dart';
import '../models/pet_model.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>{
  final PetController _controllerPet = PetController();
  List<Pet> _pets=[];
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async{
    setState(() {
      _isLoading = true;
    });
    _pets = [];
    try {
      _pets = await _controllerPet.readPets();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao Carregar os Dados $e")));
    }
  }

  //build da tela
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold();
  }
}