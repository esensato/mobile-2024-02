import { inserir, listar } from "@/components/banco-dados";
import FormularioGasto from "@/components/formulario-gasto";
import ListaItens from "@/components/lista-itens";
import ListaItensDragDrop from "@/components/lista-itens-drag-drop";
import axios from "axios";
import { useEffect, useState } from "react";
import { View, StyleSheet, SafeAreaView, StatusBar, Modal, Text, Pressable } from "react-native";

export default function Principal(props: any) {

  const [lista, setLista] = useState<any[]>([]);
  const [exibirModal, setExibirModal] = useState(false);

  const getGastos = async () => {
    const ret = await axios.get("https://controle-gastos.glitch.me/");
    console.log(ret.status);
    setLista(ret.data);
  }

  const enviarEndpoint = async (id: number, descricaoGasto: string, valorGasto: number) => {

    const ret = await axios.post('https://controle-gastos.glitch.me/', { id: id, descricao: descricaoGasto, valor: valorGasto })
    console.log(ret);

  }

  // executa uma unica vez
  useEffect(() => {
    // lista gastos do banco de dados
    //setLista(listar());
    // lista gastos do endpoint
    // gastos do endpoint
    getGastos();
  }, [])

  const criarGasto = (descricao: string, valor: number) => {

    return { id: new Date().getTime(), descricao: descricao, valor: valor };

  }

  // obtem a descricao do gasto e inclui na lista
  const adicionarOnPress = (descricao: string, valor: string) => {
    const novoGasto = criarGasto(descricao, parseFloat(valor));
    let novaLista = [...lista, novoGasto];
    // inserir no banco de dados
    inserir(novoGasto.id, novoGasto.descricao, novoGasto.valor);
    // inserir no endpoint
    enviarEndpoint(novoGasto.id, novoGasto.descricao, novoGasto.valor);
    setLista(novaLista);
    if (novaLista.length > 5) {
      setExibirModal(true);
    }
  }

  const removerItemLista = (id: number) => {

    // remove um item da lista
    //[A,B,C] => splice (1,1) => [A,C]
    let removerGasto = [...lista];
    removerGasto.splice(id, 1);
    setLista(removerGasto);

  }

  const detalhes = (descricao: string) => {
    console.log("Navegar para Detalhes...", descricao)
    props.navigation.navigate('Detalhes', { descricao: descricao });
  }

  return <View style={styles.container}>

    <Modal visible={exibirModal} transparent={true}>
      <View style={styles.centeredView}>
        <View style={styles.modalView}>
          <Text>Você excedeu o limite!!!</Text>
          <Pressable
            style={[styles.button, styles.buttonClose]}
            onPress={() => setExibirModal(!exibirModal)}>
            <Text>Fechar</Text>
          </Pressable>
        </View>
      </View>
    </Modal>

    <FormularioGasto onClick={adicionarOnPress} placeholder1="Informe o gasto" placeholder2="Valor" />

    <ListaItensDragDrop onClick={removerItemLista}
      atualizar={setLista}
      lista={lista}
      onDetailClick={detalhes} />
  </View >
}

const styles = StyleSheet.create({
  container: {
    flex: 1, // ocupa toda a dimensão vertical
    marginTop: '5%'
  },
  centeredView: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    marginTop: 22,
    borderColor: 'red'
  },
  modalView: {
    margin: 20,
    backgroundColor: 'white',
    borderRadius: 20,
    padding: 35,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.25,
    shadowRadius: 4,
    elevation: 5,
  },
  button: {
    borderRadius: 20,
    padding: 10,
    elevation: 2,
  },
  buttonClose: {
    backgroundColor: '#2196F3'
  }
});
