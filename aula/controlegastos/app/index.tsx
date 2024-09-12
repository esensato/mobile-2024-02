import { Text, View, StyleSheet } from "react-native";

export default function Index() {

  const somar = (n1: number, n2: number) => n1 + n2;

  let mensagem = "Boa noite!"
  return <View style={styles.container}>
    <Text style={styles.texto}>
      mensagem {mensagem} - {3 * 10 - 5} - {5 > 1 ? "SIM" : "NAO"}
    </Text>
    <Text style={styles.texto}>Mensagem 2</Text>
    <Text style={styles.texto}>{somar(10, 20)}</Text>
  </View >
    ;
}

const styles = StyleSheet.create({
  container: {
    flex: 1, // ocupa toda a dimensão vertical
    marginTop: '10%',
    borderWidth: 5,
    borderColor: 'red'
  },
  texto: {
    paddingTop: 10,
    paddingLeft: 5,
    paddingBottom: 10
  }
});
