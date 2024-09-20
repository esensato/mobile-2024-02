import { Text, TouchableOpacity, View } from 'react-native';
import DragList from 'react-native-draglist';

export default function ListaItensDragDrop(props: any) {

    const renderItem = (info: any) => {
        const { item, onDragStart, onDragEnd, isActive } = info;

        return (
            <TouchableOpacity
                style={{ padding: 10, backgroundColor: "#CACA" }}
                key={item.id}
                onPress={props.onClick}
                onPressIn={onDragStart}
                onPressOut={onDragEnd}>
                <View style={{ flexDirection: "row" }}>
                    <Text style={{ flex: 3 }}>{item.descricao}</Text>
                    <Text style={{ flex: 1 }}>R$ {item.valor}</Text>
                </View>
            </TouchableOpacity>
        );
    }

    const onReordered = async (fromIndex: number, toIndex: number) => {

        console.log(fromIndex, toIndex)
        const copy = [...props.lista]; // Don't modify react data in-place
        const removed = copy.splice(fromIndex, 1);

        copy.splice(toIndex, 0, removed[0]); // Now insert at the new pos
        props.atualizar(copy);
    }
    return <DragList
        data={props.lista}
        keyExtractor={(item: any) => item.id}
        onReordered={onReordered}
        renderItem={renderItem}
    />
}