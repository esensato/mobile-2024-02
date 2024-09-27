import { Text, View } from "react-native";

export default function Detalhes(props: any) {

    console.log(props.route.params);
    return <View>
        <Text style={{ fontSize: 20 }}>Detalhes</Text>
        <Text style={{ fontSize: 30 }}>{props.route.params.descricao}</Text>
    </View>

}