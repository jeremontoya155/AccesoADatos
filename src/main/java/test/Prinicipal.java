package test;

import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.TextArea;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextArea;
import static test.Prinicipal.conectar;

public class Prinicipal {

    public static void main(String[] args) {

        JFrame miMarco = new Marco_aplicacion();

        miMarco.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        miMarco.setVisible(true);

        /*Establecemos conexion*/
    }

    public void ejecutaConsulta() {

        ResultSet rs = null;

    }

    public static void conectar(String ruta, JComboBox secciones, String consulta) {

        try {
            Connection conexion = DriverManager.getConnection(ruta, "root", "");
            Statement sentencia = conexion.createStatement();

            ResultSet resultado = sentencia.executeQuery(consulta);

            while (resultado.next()) {
                secciones.addItem(resultado.getString(1));
            }

            resultado.close();
            sentencia.close();
            conexion.close();
        } catch (SQLException ex) {
            System.out.println("Error");
            ex.printStackTrace(System.out);

        }

    }

}

class Marco_aplicacion extends JFrame {

    private final String ruta = "jdbc:mysql://localhost:3306/ventas_online";
    private final String consultaMarcas = "SELECT DISTINCTROW marca FROM productos";
    private final String consultaProductos = "SELECT DISTINCTROW pais FROM productos";
    private final String consultaGeneral = "SELECT * FROM productos WHERE marca=?";
    private final String consultaGeneralPaises = "SELECT * FROM productos WHERE pais=?";
    private JComboBox secciones, paises;
    private JTextArea resultado;

    public Marco_aplicacion() {

        setTitle("Consulta Base De Datos");
        setBounds(500, 300, 400, 400);
        setLayout(new BorderLayout());
        JPanel menus = new JPanel();
        JPanel botones = new JPanel();
        menus.setLayout(new FlowLayout());
        botones.setLayout(new FlowLayout());

        secciones = new JComboBox();
        secciones.setEditable(false);
        secciones.addItem("Seleccione una marca");
        paises = new JComboBox();
        paises.setEditable(false);
        paises.addItem("Seleccione un pais");
        resultado = new JTextArea(4, 50);
        resultado.setEditable(false);
        conectar(ruta, secciones, consultaMarcas);
        conectar(ruta, paises, consultaProductos);

        add(resultado);
        menus.add(secciones);
        menus.add(paises);
        add(menus, BorderLayout.NORTH);
        add(resultado, BorderLayout.CENTER);

        JButton btnConsultaMarca = new JButton("Consulta Marca");

        JButton btnConsultaPais = new JButton("Consulta Pais");

        btnConsultaMarca.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                cargarTexto(ruta, consultaGeneral, resultado, secciones);

            }
        });

        btnConsultaPais.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                cargarTexto(ruta, consultaGeneralPaises, resultado, paises);

            }
        });

        botones.add(btnConsultaMarca);
        botones.add(btnConsultaPais);

        add(botones, BorderLayout.SOUTH);

    }

    public static void cargarTexto(String ruta, String consulta, JTextArea resultado, JComboBox secciones) {

        try {

            resultado.setText(" ");
            String seccion = (String) secciones.getSelectedItem();//Marcar el item seleccionado
            Connection conexion = DriverManager.getConnection(ruta, "root", "");

            PreparedStatement sentencia = conexion.prepareStatement(consulta);

            sentencia.setString(1, seccion);//Indicamos que vamos a enviar a ese lugar lo que nosotros querramos
            ResultSet rs = sentencia.executeQuery();

            while (rs.next()) {

                int convertir = rs.getInt(1);
                String conversion = String.valueOf(convertir);
                resultado.append((conversion));
                resultado.append(", ");
                resultado.append(rs.getString(2));
                resultado.append(", ");
                resultado.append(rs.getString(3));
                resultado.append(", ");
                resultado.append(rs.getString(4));
                resultado.append(", ");
                resultado.append(rs.getString(5));
                resultado.append("\n");

            }

            sentencia.close();
            conexion.close();
        } catch (SQLException ex) {
            System.out.println("Error");
            ex.printStackTrace(System.out);

        }

    }

}
