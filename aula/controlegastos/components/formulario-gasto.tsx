import { useState } from "react";
import { Pressable, StyleSheet, Text, TextInput, View } from "react-native";

export default function FormularioGasto(props: any) {

    const [descricao, setDescricao] = useState<string>("");
    const [valor, setValor] = useState<string>("");

    const descricaoOnChangeText = (texto: string) => {
        setDescricao(texto);
    }

    const valorOnChangeText = (texto: string) => {
        setValor(texto);
    }

    return <View style={{ flexDirection: "row" }}>
        <TextInput style={styles.input} value={descricao} placeholder={props.placeholder1} onChangeText={descricaoOnChangeText} />
        <TextInput style={styles.input} value={valor} placeholder={props.placeholder2} onChangeText={valorOnChangeText} />
        <Pressable style={{ paddingTop: 15, marginEnd: 10 }} onPress={() => {
            props.onClick(descricao, valor)
            setDescricao("");
            setValor("");
        }}>
            <Text style={{ color: "blue" }}>Adicionar Gasto</Text></Pressable>
    </View>
}

const styles = StyleSheet.create({
    input: {
        height: 40,
        margin: 5,
        borderWidth: 1,
        padding: 10,
        borderRadius: 6,
        flex: 5
    },
});