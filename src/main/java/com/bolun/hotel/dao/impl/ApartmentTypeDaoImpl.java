package com.bolun.hotel.dao.impl;

import lombok.NoArgsConstructor;
import com.bolun.hotel.dao.ApartmentTypeDao;
import com.bolun.hotel.entity.enums.ApartmentType;
import com.bolun.hotel.connection.ConnectionManager;
import com.bolun.hotel.exception.DaoException;

import java.util.List;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import static lombok.AccessLevel.PRIVATE;

@NoArgsConstructor(access = PRIVATE)
public class ApartmentTypeDaoImpl implements ApartmentTypeDao {

    private static final ApartmentTypeDao INSTANCE = new ApartmentTypeDaoImpl();
    private static final String APARTMENT_TYPE = "ap_type";

    private static final String FIND_ALL_SQL = """
            SELECT ap_type
            FROM apartment_type;
            """;

    @Override
    public List<ApartmentType> findAll() {
        try (Connection connection = ConnectionManager.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(FIND_ALL_SQL)) {
            ResultSet resultSet = preparedStatement.executeQuery();

            List<ApartmentType> apartmentTypes = new ArrayList<>();
            while (resultSet.next()) {
                apartmentTypes.add(ApartmentType.valueOf(resultSet.getString(APARTMENT_TYPE)));
            }

            return apartmentTypes;
        } catch (SQLException ex) {
            throw new DaoException(ex.getMessage(), ex);
        }
    }

    public static ApartmentTypeDao getInstance() {
        return INSTANCE;
    }
}
