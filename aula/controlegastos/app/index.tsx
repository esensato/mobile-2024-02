import { NavigationContainer } from "@react-navigation/native";
import Principal from "./principal";
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import Detalhes from "./detalhes";
import { useEffect } from "react";
import { iniciar } from "@/components/banco-dados";
import axios from 'axios';

const Stack = createNativeStackNavigator();

export default function Index() {

  // executa uma unica vez
  useEffect(() => {
    // gastos do banco de dados SQLite
    iniciar();
  }, []);

  return <NavigationContainer independent={true}>
    <Stack.Navigator>
      <Stack.Screen name="Principal" component={Principal} />
      <Stack.Screen name="Detalhes" component={Detalhes} />
    </Stack.Navigator>
  </NavigationContainer>
}