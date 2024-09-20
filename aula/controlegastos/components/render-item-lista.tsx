import { Image, StyleSheet, Text, View } from "react-native";

const imagem = require('../assets/images/coin.png');

export default function RenderItemLista(props: any) {

    return <View style={{ flexDirection: "row" }}>
        <Image source={imagem} style={{ marginTop: 12, marginLeft: 5 }} />
        <Text style={styles.item} key={props.item.id} onPress={() => {
            console.log("Chamando callback: ", props.onClick);
            props.onClick(props.id)
        }}>{props.item}</Text>
    </View>
}

const styles = StyleSheet.create({
    item: {
        height: 40,
        marginLeft: 10,
        textAlignVertical: 'center'
    }
});
