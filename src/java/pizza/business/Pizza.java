/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pizza.business;

import java.util.Iterator;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author LarryXu
 */
public class Pizza {

    private JSONObject addedToppings;
    private JSONObject extraToppings;
    private JSONObject addedToppingList;
    private JSONObject line_item;
    private int added_topping_count;
    private int extra_topping_count;
    private float item_price;
    private int toppingUnit;
    private String imagePath;
    private String cutImagePath;
    private float topping_total_price;
    
    public Pizza(JSONObject addedToppings,
            JSONObject extraToppings,
            JSONObject addedToppingList,
            JSONObject line_item,
            int added_topping_count) {
        this.addedToppings = addedToppings;
        this.extraToppings = extraToppings;
        this.addedToppingList = addedToppingList;
        this.line_item = line_item;
        this.topping_total_price = 0;
        this.added_topping_count = added_topping_count;
        this.extra_topping_count = 0;
        this.toppingUnit = 0;
    }
    
    public String getImagePath() {
        return imagePath;
    }
    
    public String getCutImagePath() {
        return cutImagePath;
    }

    public JSONObject getLine_item() {
        return line_item;
    }

    public float getTopping_total_price() {
        return topping_total_price;
    }

    public int getToppingUnit() {
        return toppingUnit;
    }

    public float getItem_price() {
        return item_price;
    }
    
    public JSONObject getAddedToppings() {
        return addedToppings;
    }

    public JSONObject getExtraToppings() {
        return extraToppings;
    }
    
    public void checkTopping(JSONObject params) 
            throws JSONException {
        String toppingName = params.getString("topping_name");
        toppingUnit
            = (addedToppings.has(toppingName)
                ? addedToppings.getJSONObject(toppingName).getInt("qty") : 0)
            + (extraToppings.has(toppingName)
                ? extraToppings.getJSONObject(toppingName).getInt("qty") : 0);
    }

    public void addTopping(JSONObject params) 
            throws JSONException {
        String toppingName = params.getString("topping_name");
        item_price = Float.parseFloat(this.line_item.getString("item_price"));

        toppingUnit
            = (addedToppings.has(toppingName)
                ? addedToppings.getJSONObject(toppingName).getInt("qty") : 0)
            + (extraToppings.has(toppingName)
                ? extraToppings.getJSONObject(toppingName).getInt("qty") : 0);
        float old_price = 0;

        if (toppingUnit == 0) {
            if (!addedToppings.has(toppingName) 
                    && !extraToppings.has(toppingName)) {
                JSONObject topping = new JSONObject();
                topping.put("pos", "both");
                topping.put("qty", 1);
                topping.put("id", addedToppingList.getJSONObject(toppingName).getInt("id"));
                extraToppings.put(toppingName, topping);
                extra_topping_count += 1;
                old_price = item_price;
                item_price += Float.parseFloat(addedToppingList.getJSONObject(toppingName).getString("price"));
            } else if (addedToppings.has(toppingName)
                    && !extraToppings.has(toppingName)
                    && addedToppings.getJSONObject(toppingName).getInt("qty") == 0) {
                int qty = addedToppings.getJSONObject(toppingName).getInt("qty");
                addedToppings.getJSONObject(toppingName).put("qty", qty + 1);
                added_topping_count += 1;
                old_price = item_price;
            }

            toppingUnit
                = (addedToppings.has(toppingName)
                    ? addedToppings.getJSONObject(toppingName).getInt("qty") : 0)
                + (extraToppings.has(toppingName)
                    ? extraToppings.getJSONObject(toppingName).getInt("qty") : 0);

        } else {
            if (addedToppings.has(toppingName)
                    && !extraToppings.has(toppingName)
                    && addedToppings.getJSONObject(toppingName).getInt("qty") == 1) {
                JSONObject topping = new JSONObject();
                topping.put("pos", "both");
                topping.put("qty", 1);
                topping.put("id", addedToppingList.getJSONObject(toppingName).getInt("id"));
                extraToppings.put(toppingName, topping);
                extra_topping_count += 1;
                old_price = item_price;
                item_price += Float.parseFloat(addedToppingList.getJSONObject(toppingName).getString("price"));
            } else if (!addedToppings.has(toppingName)
                    && extraToppings.has(toppingName)
                    && extraToppings.getJSONObject(toppingName).getInt("qty") == 1) {
                int qty = extraToppings.getJSONObject(toppingName).getInt("qty");
                extraToppings.getJSONObject(toppingName).put("qty", qty + 1);
                extra_topping_count += 1;
                old_price = item_price;
                item_price += Float.parseFloat(addedToppingList.getJSONObject(toppingName).getString("price"));
            }

            toppingUnit
                = (addedToppings.has(toppingName)
                    ? addedToppings.getJSONObject(toppingName).getInt("qty") : 0)
                + (extraToppings.has(toppingName)
                    ? extraToppings.getJSONObject(toppingName).getInt("qty") : 0);
        }
        int qty = this.line_item.getInt("item_qty");
        float old_subtotal = old_price * qty;
        float subtotal = item_price * qty;
        topping_total_price = subtotal - old_subtotal;
        line_item.put("item_price", String.format("%.2f", this.item_price));
        line_item.put("item_toppings", this.combineToppingList());
    }

    public void removeTopping(JSONObject params)
            throws JSONException {
        String toppingName = params.getString("topping_name");
        item_price = Float.parseFloat(this.line_item.getString("item_price"));
        float old_price = 0;

        if (!addedToppings.has(toppingName)
                && extraToppings.has(toppingName)
                && extraToppings.getJSONObject(toppingName).getInt("qty") == 2) {
            int qty = extraToppings.getJSONObject(toppingName).getInt("qty");
            extraToppings.getJSONObject(toppingName).put("qty", qty - 1);
            extra_topping_count -= 1;
            old_price = item_price;
            item_price -= Float.parseFloat(addedToppingList.getJSONObject(toppingName).getString("price"));
        } else if (!extraToppings.has(toppingName)
                && addedToppings.has(toppingName)
                && addedToppings.getJSONObject(toppingName).getInt("qty") == 2) {
            int qty = addedToppings.getJSONObject(toppingName).getInt("qty");
            addedToppings.getJSONObject(toppingName).put("qty", qty - 1);
            added_topping_count -= 1;
            old_price = item_price;
            item_price -= Float.parseFloat(addedToppingList.getJSONObject(toppingName).getString("price"));
        }
        else if ( !addedToppings.has(toppingName)
                || addedToppings.getJSONObject(toppingName).getInt("qty") == 1
                && (extraToppings.has(toppingName)
                && extraToppings.getJSONObject(toppingName).getInt("qty") == 1) ) {
            extraToppings.remove(toppingName);
            extra_topping_count -= 1;
            old_price = item_price;
            item_price -= Float.parseFloat(addedToppingList.getJSONObject(toppingName).getString("price"));
        } else if (addedToppings.has(toppingName)
                && !extraToppings.has(toppingName)
                && addedToppings.getJSONObject(toppingName).getInt("qty") == 1) {
            int qty = addedToppings.getJSONObject(toppingName).getInt("qty");
            addedToppings.getJSONObject(toppingName).put("qty", qty - 1);
            added_topping_count -= 1;
            old_price = item_price;
        }

        toppingUnit
            = (addedToppings.has(toppingName)
                ? addedToppings.getJSONObject(toppingName).getInt("qty") : 0)
            + (extraToppings.has(toppingName)
                ? extraToppings.getJSONObject(toppingName).getInt("qty") : 0);

        int qty = this.line_item.getInt("item_qty");
        float old_subtotal = old_price * qty;
        float subtotal = item_price * qty;
        topping_total_price = subtotal - old_subtotal;
        line_item.put("item_price", String.format("%.2f", this.item_price));
        line_item.put("item_toppings", this.combineToppingList());
    }
    
    public void changeOption(JSONObject params) 
            throws JSONException {
        String checkedOption = params.getString("checkedOption");
        String checkedOptionName = params.getString("checkedOptionName");

        JSONObject item_prices = this.line_item.getJSONObject("item_prices");
        item_price = Float.parseFloat(this.line_item.getString("item_price"));
        float old_price = item_price;
        float base_price = 0;
        float old_base_price = 0;

        if ("Crust Style".equals(checkedOptionName)) {
            if ("GLUTEN-FREE".equals(checkedOption)) {

                if ("ORIGINAL".equals(addedToppings.getJSONObject("Crust Style").getString("ingred_name"))) {
                    old_base_price = Float.parseFloat(item_prices.getString(addedToppings.getJSONObject("Size").getString("ingred_name")));
                } else if ("THIN".equals(addedToppings.getJSONObject("Crust Style").getString("ingred_name"))) {
                    old_base_price = Float.parseFloat(item_prices.getString(addedToppings.getJSONObject("Crust Style").getString("ingred_name")));
                }

                addedToppings.getJSONObject("Size").put("ingred_name", "SMALL");
                addedToppings.getJSONObject(checkedOptionName).put("ingred_name", checkedOption);
                base_price = Float.parseFloat(item_prices.getString(checkedOption));
                item_price = item_price - old_base_price + base_price;

                imagePath = "../images/pizzaBuilder/" + addedToppings.getJSONObject("Size").getString("ingred_name") + ".jpg";
                cutImagePath = "../images/pizzaBuilder/" + addedToppings.getJSONObject("Size").getString("ingred_name") + "-" + addedToppings.getJSONObject("Cut").getString("ingred_name") + "-CUT.png";
            } else if ("THIN".equals(checkedOption)) {

                if ("ORIGINAL".equals(addedToppings.getJSONObject("Crust Style").getString("ingred_name"))) {
                    old_base_price = Float.parseFloat(item_prices.getString(addedToppings.getJSONObject("Size").getString("ingred_name")));
                } else if ("GLUTEN-FREE".equals(addedToppings.getJSONObject("Crust Style").getString("ingred_name"))) {
                    old_base_price = Float.parseFloat(item_prices.getString(addedToppings.getJSONObject("Crust Style").getString("ingred_name")));
                }

                addedToppings.getJSONObject("Size").put("ingred_name", "LARGE");
                addedToppings.getJSONObject(checkedOptionName).put("ingred_name", checkedOption);
                base_price = Float.parseFloat(item_prices.getString(checkedOption));
                item_price = item_price - old_base_price + base_price;

                imagePath = "../images/pizzaBuilder/" + addedToppings.getJSONObject("Crust Style").getString("ingred_name") + ".jpg";
                cutImagePath = "../images/pizzaBuilder/" + addedToppings.getJSONObject("Size").getString("ingred_name") + "-" + addedToppings.getJSONObject("Cut").getString("ingred_name") + "-CUT.png";
            } else if ("ORIGINAL".equals(checkedOption)) {
                old_base_price = Float.parseFloat(item_prices.getString(addedToppings.getJSONObject("Crust Style").getString("ingred_name")));

                addedToppings.getJSONObject("Size").put("ingred_name", "LARGE");
                addedToppings.getJSONObject(checkedOptionName).put("ingred_name", checkedOption);
                base_price = Float.parseFloat(item_prices.getString("LARGE"));
                item_price = item_price - old_base_price + base_price;

                imagePath = "../images/pizzaBuilder/" + addedToppings.getJSONObject("Size").getString("ingred_name") + ".jpg";
                cutImagePath = "../images/pizzaBuilder/" + addedToppings.getJSONObject("Size").getString("ingred_name") + "-" + addedToppings.getJSONObject("Cut").getString("ingred_name") + "-CUT.png";
            }
        } else if ("Size".equals(checkedOptionName) ||
                   "Cut".equals(checkedOptionName)) {
            old_base_price = Float.parseFloat(item_prices.getString(addedToppings.getJSONObject("Size").getString("ingred_name")));
            addedToppings.getJSONObject(checkedOptionName).put("ingred_name", checkedOption);
            if ("Size".equals(checkedOptionName)) {
                base_price = Float.parseFloat(item_prices.getString(checkedOption));
                item_price = item_price - old_base_price + base_price;
            }

            imagePath = "../images/pizzaBuilder/" + addedToppings.getJSONObject("Size").getString("ingred_name") + ".jpg";
            cutImagePath = "../images/pizzaBuilder/" + addedToppings.getJSONObject("Size").getString("ingred_name") + "-" + addedToppings.getJSONObject("Cut").getString("ingred_name") + "-CUT.png";
        } else if("Sauce".equals(checkedOptionName)) {
            addedToppings.getJSONObject(checkedOptionName).put("ingred_name", checkedOption);
            imagePath = "../images/pizzaBuilder/" + addedToppings.getJSONObject("Sauce").getString("ingred_name") + "-SAUCE.jpg";
        } else {
            addedToppings.getJSONObject(checkedOptionName).put("ingred_name", checkedOption);
        }

        int qty = this.line_item.getInt("item_qty");
        float old_subtotal = old_price * qty;
        float subtotal = item_price * qty;
        topping_total_price = subtotal - old_subtotal;
        line_item.put("item_price", String.format("%.2f", this.item_price));
        line_item.put("item_toppings", this.combineToppingList());
    }
    
    public void changeToppingPosition(JSONObject params) 
            throws JSONException {
        String toppingName = params.getString("topping_name");
        String position = params.getString("position");
        if (this.addedToppings.has(toppingName)) {
            this.addedToppings.getJSONObject(toppingName).put("pos", position);
        }
        if (this.extraToppings.has(toppingName)) {
            this.extraToppings.getJSONObject(toppingName).put("pos", position);
        }
        line_item.put("item_toppings", this.combineToppingList());
    }
    
    public JSONObject combineToppingList() throws JSONException {
        JSONObject combinedToppingList = new JSONObject();
        Iterator<?> keysItr = this.addedToppings.keys();
        while (keysItr.hasNext()) {
            String key = (String)keysItr.next();
            combinedToppingList.put(key, getAddedToppings().getJSONObject(key));
        }

        Iterator<?> keysItr1 = this.extraToppings.keys();
        while (keysItr1.hasNext()) {
            String key = (String)keysItr1.next();
            if (combinedToppingList.has(key)) {
                int qty = combinedToppingList.getJSONObject(key).getInt("qty");
                combinedToppingList.getJSONObject(key).put("qty", qty + extraToppings.getJSONObject(key).getInt("qty"));
                extraToppings.remove(key);
            } else {
                combinedToppingList.put(key, extraToppings.getJSONObject(key));
            }
        }
        return combinedToppingList;
    }
    
}
