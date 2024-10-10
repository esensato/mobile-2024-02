import { useState } from "react";
import { StyleSheet, View, Text, Button } from "react-native";
import MapView, { Callout, MapPressEvent, Marker, UrlTile } from 'react-native-maps';

export default function Index() {

  const [marcadores, addMarcador] = useState([{ key: "1", title: "ESPM JT", description: "ESPM Tech", coord: { latitude: -23.586931331827458, longitude: -46.64433318786136 } },
  { key: "2", title: "ESPM AA", description: "ESPM", coord: { latitude: -23.58967846882238, longitude: -46.63990526132676 } },
  { key: "3", title: "SC Lanches", description: "São Carlos Lanches", coord: { latitude: -23.58938350012329, longitude: -46.63921861582784 } }
  ])

  return (
    <View
      style={{
        flex: 1,
        justifyContent: "center",
        alignItems: "center",
      }}
    >
      <MapView
        style={styles.map}
        onPress={(aqui: MapPressEvent) => {
          console.log(aqui.nativeEvent.coordinate);
          const id = "id" + Date.now();
          addMarcador([...marcadores,
          {
            key: id, title: "Novo", description: "Novo", coord: { latitude: aqui.nativeEvent.coordinate.latitude, longitude: aqui.nativeEvent.coordinate.longitude }
          }]);
        }}
        initialRegion={{
          latitude: -23.58701982416051,
          longitude: -46.64434391669733,
          latitudeDelta: 0.0922,
          longitudeDelta: 0.0421,
        }}>

        <UrlTile urlTemplate="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" maximumZ={19} />

        {marcadores.map((item: any) => (
          <Marker draggable
            image={require('../assets/images/favicon.png')}
            key={item.key}
            onDragEnd={(e) => console.log(e.nativeEvent.coordinate)}
            coordinate={item.coord}
            title={item.title}
            description={item.description}>
            <Callout>
              <View style={{ borderWidth: 3, borderColor: "black" }}><Text>{item.description}</Text>
                <Text>{item.coord.latitude}</Text>
                <Text>{item.coord.longitude}</Text>
                <Button title="OK" /></View>
            </Callout>


          </Marker>
        ))}

      </MapView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    ...StyleSheet.absoluteFillObject,
    height: '100%',
    width: '100%',
  },
  map: {
    ...StyleSheet.absoluteFillObject,
  },
});
