import { FlatList } from "react-native";
import RenderItemLista from "./render-item-lista";

export default function ListaItens(props: any) {

    return <FlatList data={props.lista}
        renderItem={({ item, index }) => <RenderItemLista item={item} id={index} onClick={props.onClick} />}
        keyExtractor={idx => idx} />

}