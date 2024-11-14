## Android Nativo
- [Developer Android](https://developer.android.com/?hl=pt-br)
- Selecionar como modelo o **Empty Views Activity** e a linguagem **Java**
- Classe principal deve especializar `AppCompatActivity`
```java
public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

    }
}
```
- Componentes da interface podem ser acessados por meio do `findViewById()`
```java
        Toast.makeText(
                context,
                "Botão Clicado!",
                Toast.LENGTH_SHORT).show();
```

```java
@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);

    TextView txt = findViewById(R.id.texto_exemplo);
    txt.setText("Nova frase");
}
```
- Criar um botão e alterar a frase exibida quando clicado
```java
public void mudarFraseOnClick (View view) {

    TextView txt = findViewById(R.id.texto_exemplo);
    txt.setText("Nova frase");
}
```
- Incluir um campo de texto para que o usuário informe a frase a ser exibida
```javascript
public void mudarFraseOnClick (View view) {

    EditText edt = findViewById(R.id.edtTexto);
    TextView txt = findViewById(R.id.texto_exemplo);
    txt.setText(edt.getText().toString());
}
```
- Método para gerar números aleatórios entre 1 e 100
```java
private int sortearNumero() {
    Random random = new Random();
    return random.nextInt(100) + 1;
}
```
- Utilizar a implementação abaixo para calcular o quanto próximo o número escolhido pelo usuário está do que foi sorteado
```java
private int calcularProgress(int chute) {

    return (chute * 50) / this.numeroSorteado;

}
```
- Incluir um `SeekBar` com o atributo `android:max="100"` e `android:progress="50"`
```java
seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
    @Override
    public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
        atualizarValor(progress);
    }

    @Override
    public void onStartTrackingTouch(SeekBar seekBar) {
    }

    @Override
    public void onStopTrackingTouch(SeekBar seekBar) {
    }
});

```
- Incluir um `ProgressBar`
- Alterar o estilo da `ProgressBar` em um arquivo `progress_bar_custom.xml` na pasta `drawable`
```xml
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">

        <item android:id="@android:id/background">

            <shape android:shape="rectangle">

                <corners android:radius="6dp" />
                <solid android:color="@color/design_default_color_secondary" />

            </shape>

        </item>

    <item android:id="@android:id/progress">

        <scale android:scaleWidth="100%">

            <shape android:shape="rectangle">

                <corners android:radius="6dp" />
                <solid android:color="@color/design_default_color_primary" />

            </shape>
        </scale>


    </item>

</layer-list>
```
- Aplicar o estilo no atributo `android:progressDrawable="@drawable/progress_bar_custom"`
***
### Databinding
- Habilitar a *feature* dentro do arquivo `build.gradle`
```javascript
buildFeatures{
    dataBinding = true
}
```
- Criar um novo arquivo de *layout* (`activity_main_databinding.xml`) com base no anterior e efetuar as alterações:
    - Incluir a tag `layout` englobando todos os elementos
    - Mover as declarações `xmlns` do `androidx.constraintlayout.widget.ConstraintLayout` para o `layout`
```xml
<?xml version="1.0" encoding="utf-8"?>

<layout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools">
    
    <androidx.constraintlayout.widget.ConstraintLayout
        android:id="@+id/main"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        tools:context=".MainActivity">

        <TextView
            android:id="@+id/txtDica"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_marginTop="32dp"
            android:text=""
            app:layout_constraintEnd_toEndOf="parent"
            app:layout_constraintStart_toStartOf="parent"
            app:layout_constraintTop_toTopOf="parent" />

        <Button
            android:id="@+id/button"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_marginBottom="138dp"
            android:onClick="chutarOnClick"
            android:text="Chutar"
            app:layout_constraintBottom_toBottomOf="parent"
            app:layout_constraintEnd_toEndOf="parent"
            app:layout_constraintHorizontal_bias="0.498"
            app:layout_constraintStart_toStartOf="parent" />

        <SeekBar
            android:id="@+id/sbChute"
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_marginTop="156dp"
            android:max="100"
            android:progress="50"
            app:layout_constraintEnd_toEndOf="parent"
            app:layout_constraintHorizontal_bias="0.0"
            app:layout_constraintStart_toStartOf="parent"
            app:layout_constraintTop_toBottomOf="@+id/pbDica" />

        <ProgressBar
            android:id="@+id/pbDica"
            style="?android:attr/progressBarStyleHorizontal"
            android:layout_width="0dp"
            android:layout_height="20dp"
            android:layout_marginTop="144dp"
            android:progressDrawable="@drawable/progress_bar_custom"
            app:layout_constraintEnd_toEndOf="parent"
            app:layout_constraintHorizontal_bias="0.0"
            app:layout_constraintStart_toStartOf="parent"
            app:layout_constraintTop_toTopOf="parent" />

        <TextView
            android:id="@+id/txtValorChute"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:layout_marginBottom="16dp"
            android:text="TextView"
            app:layout_constraintBottom_toTopOf="@+id/sbChute"
            app:layout_constraintEnd_toEndOf="parent"
            app:layout_constraintStart_toStartOf="parent" />

        <TextView
            android:id="@+id/textView2"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="|"
            app:layout_constraintEnd_toEndOf="parent"
            app:layout_constraintStart_toStartOf="parent"
            app:layout_constraintTop_toTopOf="@+id/pbDica" />

    </androidx.constraintlayout.widget.ConstraintLayout>

</layout>
```
- Criar uma classe para representar todos os dados que serão exibidos na tela
```java
import androidx.databinding.BaseObservable;
import androidx.databinding.Bindable;

public class QualNumero extends BaseObservable {

    @Bindable
    public String dica = "";
    @Bindable
    public int chute = 50;
    @Bindable
    public String chuteText = "50";
    @Bindable
    public int valorProgressBar = 0;
}
```
- Declarar como os dados serão incorporados no layout
```xml
    <data>
        <variable
            name="qualnumero"
            type="com.example.qualnumero.QualNumero" />

    </data>
```
- Referenciar os atributos declarados na classe `QualNumero` nos componentes de interface onde serão utilizados
```xml
<TextView
    android:id="@+id/txtDica"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:layout_marginTop="32dp"
    android:text="@{qualnumero.dica}"
    app:layout_constraintEnd_toEndOf="parent"
    app:layout_constraintStart_toStartOf="parent"
    app:layout_constraintTop_toTopOf="parent" />

<SeekBar
    android:id="@+id/sbChute"
    android:layout_width="0dp"
    android:layout_height="wrap_content"
    android:layout_marginTop="156dp"
    android:max="100"
    android:progress="@{qualnumero.chute}"
    app:layout_constraintEnd_toEndOf="parent"
    app:layout_constraintHorizontal_bias="0.0"
    app:layout_constraintStart_toStartOf="parent"
    app:layout_constraintTop_toBottomOf="@+id/pbDica" />

<ProgressBar
    android:id="@+id/pbDica"
    style="?android:attr/progressBarStyleHorizontal"
    android:layout_width="0dp"
    android:layout_height="20dp"
    android:layout_marginTop="144dp"
    android:progress="@{qualnumero.valorProgressBar}"
    android:progressDrawable="@drawable/progress_bar_custom"
    app:layout_constraintEnd_toEndOf="parent"
    app:layout_constraintHorizontal_bias="0.0"
    app:layout_constraintStart_toStartOf="parent"
    app:layout_constraintTop_toTopOf="parent" />

<TextView
    android:id="@+id/txtValorChute"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:layout_marginBottom="16dp"
    android:text="@{qualnumero.chuteText}"
    app:layout_constraintBottom_toTopOf="@+id/sbChute"
    app:layout_constraintEnd_toEndOf="parent"
    app:layout_constraintStart_toStartOf="parent" />
```
- A classe que implementa a *Activity* deve ser alterada para utilizar o *binding*
```java
    private ActivityMainDatabindingBinding binding;
    private  QualNumero qualNumero;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main_databinding);

        qualNumero = new QualNumero();
        qualNumero.dica = "O número já foi sorteado!";
        binding = DataBindingUtil.setContentView(this, R.layout.activity_main_databinding);
        binding.setQualnumero(qualNumero);
        binding.setClickHandler(this);
        binding.setProgressChange(this);
    }
```
- Incluir a referência ao método acionado quando o usuário clicar no botão do chute
- Declarar como os dados serão incorporados no layout
```xml
    <data>
        <variable
            name="qualnumero"
            type="com.example.qualnumero.QualNumero" />

        <variable
            name="clickHandler"
            type="com.example.qualnumero.QualNumero.QualNumeroOnClick" />

        <variable
            name="progressChange"
            type="com.example.qualnumero.MainActivityDataBinding" />
    </data>
```
- Implementar os métodos em resposta aos eventos que ocorrerão na interface
```java
public void chuteOnClick(View view) {

    qualNumero.valorProgressBar = 10;
    qualNumero.notifyPropertyChanged(BR.valorProgressBar);

}

public void onChuteChanged(SeekBar seekBar, int progress, boolean fromUser) {

    qualNumero.chuteText = String.valueOf(progress);
    qualNumero.notifyPropertyChanged(BR.chuteText);
    Log.i("QualNumero", "Chute: " + progress);

}
```
- Registrar a própria *Activity* como *listener* para os eventos (o ideal é criar uma classe separada para isso) complementando o método `onCreate`
```java
binding.setClickHandler(this);
binding.setProgressChange(this);
```
### Jetpack Compose
```java
class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            SortearNumeros();
        }
    }
}

@Composable
fun SortearNumeros() {

    var n1 by remember { mutableIntStateOf(0) }
    var n2 by remember { mutableIntStateOf(0) }
    var resultado by remember { mutableStateOf("") }

    Column (
        modifier = Modifier
            .fillMaxSize()
            .background(Color.Cyan),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center) {

        Text(
            text = "Adivinhe...")
        Spacer(modifier = Modifier.height(10.dp))
        Text(
            text = "Quanto é $n1 x $n2?"
        )
        Button(onClick = {
            n1 = Random.nextInt(1, 10)
            n2 = Random.nextInt(1, 10)
        }) {
            Text("Sortear")
        }
        TextField(
            value = resultado,
            onValueChange = { resultado = it },
            label = { Text("Informe o resultado") }
        )

    }

}

@Preview
@Composable
fun PreviewSortearNumeros() {
    TabuadaJetpackTheme {
        SortearNumeros();
    }
}
```
